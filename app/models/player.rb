class Player
  attr_accessor :id, :name, :email, :password, :api_key, :registered_at,
    :leagues, :invited_leagues, :gravatar, :invited_teams

  attr_accessor :confirmed_password, :error, :saved,
    :accepted_invite, :declined_invite

  def self.from_hash(player)
    new_player = Player.new
    new_player.id = player[:id] if player.has_key?(:id)
    new_player.name = player[:name] if player.has_key?(:name)
    new_player.email = player[:email] if player.has_key?(:email)
    new_player.api_key = player[:api_key] if player.has_key?(:api_key)
    new_player.registered_at = player[:registered_at] if player.has_key?(:registered_at)
    new_player
  end

  def signup(&block)
    @saved = false
    if valid_signup_credentials?
      save(&block)
    else
      block.call
    end
  end

  def login(&block)
    if valid_login_credentials?
      authenticate(&block)
    else
      block.call
    end
  end

  def logged_in?
    @api_key.class == String && @api_key.length == 32
  end

  def accepted_another_unrejected_team?
    @invited_teams.each do |team|
      return true if !team.nullified? && team.was_accepted_by(self)
    end
    false
  end

  def accepted_and_unrejected_team
    @invited_teams.each do |team|
      return team if !team.nullified? && team.was_accepted_by(self)
    end
  end

  def populate_leagues(&block)
    BW::HTTP.get(BaseURL + "/player/#{@id}/leagues/#{@api_key}") do |response|
      league_hashes = BW::JSON.parse(response.body.to_str)
      @leagues = league_hashes.map { |league_json| League.from_hash(league_json) }
      block.call
    end
  end

  def populate_invited_leagues(&block)
    BW::HTTP.get(BaseURL + "/player/#{@id}/invited_leagues/#{@api_key}") do |response|
      league_invite_hashes = BW::JSON.parse(response.body.to_str)
      @invited_leagues = league_invite_hashes.map do |league_invite_json|
        League.from_hash(league_invite_json)
      end
      block.call
    end
  end

  def accept_league_invitation(league, &block)
    @accepted_invite = false
    BW::HTTP.put(BaseURL + "/player/#{@id}/accept_league/#{league.id}/#{@api_key}") do |response|
      @accepted_invite = true if response.ok?
      block.call
    end
  end

  def decline_league_invitation(league, &block)
    @declined_invite = false
    BW::HTTP.delete(BaseURL + "/player/#{@id}/decline_league/#{league.id}/#{@api_key}") do |response|
      @declined_invite = true if response.ok?
      block.call
    end
  end

  def grab_gravatar(&block)
    md5_email = NSData.MD5HexDigest(@email.downcase.dataUsingEncoding(NSUTF8StringEncoding))
    url = "http://www.gravatar.com/avatar/#{md5_email}?s=60&d=monsterid"
    BW::HTTP.get(url) do |response|
      @gravatar = response.body.uiimage
      block.call
    end
  end

  def populate_invited_teams(season, &block)
    BW::HTTP.get(BaseURL + "/player/#{@id}/season/#{season.id}/invited_teams/#{@api_key}") do |response|
      invited_teams_hashes = BW::JSON.parse(response.body.to_str)
      @invited_teams = invited_teams_hashes.map { |team_json| Team.from_hash(team_json, with_season:season) }
      block.call
    end
  end

  def accept_team_invitation(team, &block)
    @accepted_invite = false
    BW::HTTP.put(BaseURL + "/player/#{@id}/accept_team/#{team.id}/#{@api_key}") do |response|
      @accepted_invite = true if response.ok?
      block.call
    end
  end

  def decline_team_invitation(team, &block)
    @declined_invite = false
    BW::HTTP.put(BaseURL + "/player/#{@id}/decline_team/#{team.id}/#{@api_key}") do |response|
      @declined_invite = true if response.ok?
      block.call
    end
  end

  private

  def authenticate(&block)
    data = {:player => {:email => @email,
                        :password => @password,
    }}
    BW::HTTP.post(BaseURL + '/login', {:payload => data}) do |response|
      if response.ok?
        json = BW::JSON.parse(response.body.to_str)
        @id = json['id']
        @name = json['name']
        @api_key = json['api_key']
      else
        @error = 'Bad credentials'
      end
      block.call
    end
  end

  def save(&block)
    data = {:player => {:name => @name,
                        :email => @email,
                        :password => @password,
    }}
    BW::HTTP.post(BaseURL + '/player', {:payload => data}) do |response|
      if response.ok?
        @saved = true
      else
        @error = 'Email in use'
        @saved = false
      end
      block.call
    end
  end

  def valid_login_credentials?
    if valid_email && valid_password
      true
    else
      false
    end
  end

  def valid_signup_credentials?
    if valid_name && valid_email && valid_password && password_confirmed
      true
    else
      false
    end
  end

  def valid_name
    if @name.class == String && @name.length >= 5 && @name.length <= 50
      true
    else
      @error = 'Names are 5-50 long'
      false
    end
  end

  def valid_email
    if @email.class == String && ((@email =~ /\A.+@.+\.(com|org|net|ca|us|co\.uk)\z/) == 0) && @email.length >= 6 && @email.length <= 75
      true
    else
      @error = 'Valid emails are 6-75 long'
      false
    end
  end

  def valid_password
    if @password.class == String && @password.length >= 4
      true
    else
      @error = 'Passwords are at least 4 long'
      false
    end
  end

  def password_confirmed
    if @password == @confirmed_password
      true
    else
      @error = 'Mismatched passwords'
      false
    end
  end
end
