class Player
  attr_accessor :id, :name, :email, :password, :api_key, :registered_at

  attr_accessor :confirmed_password, :error, :saved, :leagues, :league_invites,
    :accepted_invite, :declined_invite, :gravatar

  # from hash
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
      send_signup_request(&block)
    else
      block.call
    end
  end

  def login(&block)
    if valid_login_credentials?
      send_login_request(&block)
    else
      block.call
    end
  end

  def logged_in?
    @api_key.class == String && @api_key.length == 32
  end

  def populate_leagues(&block)
    BW::HTTP.get(BaseURL + "/player/#{@id}/leagues/#{@api_key}") do |response|
      @leagues = []
      league_hashes = BW::JSON.parse(response.body.to_str)
      league_hashes.each do |hash|
        @leagues << League.from_hash(hash)
      end
      block.call
    end
  end

  def populate_invites(&block)
    BW::HTTP.get(BaseURL + "/player/#{@id}/league_invites/#{@api_key}") do |response|
      @league_invites = []
      league_invite_hashes = BW::JSON.parse(response.body.to_str)
      league_invite_hashes.each do |hash|
        @league_invites << League.from_hash(hash)
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
    url = "http://www.gravatar.com/avatar/#{md5_email}?s=100&d=monsterid"
    BW::HTTP.get(url) do |response|
      @gravatar = response.body.uiimage
      block.call
    end
  end

  private

  def send_login_request(&block)
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

  def send_signup_request(&block)
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
