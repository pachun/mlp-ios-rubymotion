class League
  attr_accessor :id, :name, :commissioner, :current_season, :created_at,
    :players_per_team, :plays_balls_back, :rerack_cups, :extra_point_cups,
    :error, :invitable_players, :updated, :players

  # constructor from hash
  def self.from_hash(league_hash)
    league = League.new
    league.id = league_hash[:id] if league_hash.has_key?(:id)
    league.name = league_hash[:name] if league_hash.has_key?(:name)
    league.commissioner = Player.from_hash(league_hash[:commissioner]) if league_hash.has_key?(:commissioner)
    league.current_season = Season.from_hash(league_hash[:current_season]) if league_hash.has_key?(:current_season)
    league.created_at = league_hash[:created_at] if league_hash.has_key?(:created_at)
    league.players_per_team = league_hash[:players_per_team] if league_hash.has_key?(:players_per_team)
    league.plays_balls_back = league_hash[:plays_balls_back] if league_hash.has_key?(:plays_balls_back)
    league.rerack_cups = league_hash[:rerack_cups] if league_hash.has_key?(:rerack_cups)
    league.extra_point_cups = league_hash[:extra_point_cups] if league_hash.has_key?(:extra_point_cups)
    league
  end

  # UI entry points
  def create(&block)
    @created = false
    if valid_name? && valid_ppt?
      send_create_request(&block)
    else
      block.call
    end
  end

  # requests only called in code; no error checking
  def populate_invitable_players(&block)
    @invitable_players = []
    BW::HTTP.post(BaseURL + "/league/#{@id}/invitable_players/#{@commissioner.api_key}") do |response|
      BW::JSON.parse(response.body.to_str).each do |p|
        player = InvitedPlayer.new
        player.id = p[:id]
        player.name = p[:name]
        player.invited = p[:invited]
        player.accepted_invite = p[:accepted_invite]
        @invitable_players << player
      end
      block.call
    end
  end

  def invite(player, &block)
    BW::HTTP.post(BaseURL + "/league/#{@id}/invite/#{player.id}/#{@commissioner.api_key}") do |response|
      if response.ok?
        player.invited = true
      end
      block.call
    end
  end

  def set_current_season(season, &block)
    @updated = false
    @current_season = season
    data = {:league => {:current_season_id => @current_season.id}}
    BW::HTTP.put(BaseURL + "/league/#{@id}/#{@commissioner.api_key}", {payload: data}) do |response|
      @updated = true if response.ok?
      block.call
    end
  end

  def get_players(player, &block)
    BW::HTTP.get(BaseURL + "/league/#{@id}/players/#{player.api_key}") do |response|
      json_players = BW::JSON.parse(response.body.to_str)
      @players = json_players.map { |p| Player.from_hash(p) }
      get_player_gravatars(&block)
    end
  end

  def get_player_gravatars(&block)
    @players.each do |player|
      player.grab_gravatar do
        block.call if all_gravatars_in
      end
    end
  end

  def all_gravatars_in
    all_in = true
    @players.each do |player|
      all_in = false if player.gravatar.nil?
    end
    all_in
  end

  # shortcuts
  def created?
    @id.class == Fixnum
  end

  def player_for(p)
    @players.select { |player| player.id == p.id }.first
  end

  # setter overrides for reading formotion input
  def rerack_cups_from_fm=(formotion_hash)
    @rerack_cups = ''
    formotion_hash.each_with_index do |(_,results_in_rerack), cup_number|
      if results_in_rerack
        @rerack_cups += ',' if @rerack_cups.length > 0
        @rerack_cups += (cup_number + 1).to_s
      end
    end
  end

  def extra_point_cups_from_fm=(formotion_hash)
    @extra_point_cups = ''
    formotion_hash.each_with_index do |(_,worth_extra_points), cup_number|
      if worth_extra_points
        @extra_point_cups += ',' if @extra_point_cups.length > 0
        @extra_point_cups += (cup_number + 1).to_s
      end
    end
  end

  private

  # validations
  def valid_name?
    if @name.class == String && @name.length >= 2 && @name.length <= 20
      true
    else
      @error = 'Names are 2-20 long'
      false
    end
  end

  def valid_ppt?
    if @players_per_team == 2 || @players_per_team == 3
      true
    else
      @error = 'Either 2 or 3 players per team'
      false
    end
  end

  # requests
  def send_create_request(&block)
    data = {:league => {:name => @name,
                        :commissioner_id => @commissioner.id,
                        :players_per_team => @players_per_team,
                        :plays_balls_back => @plays_balls_back,
                        :rerack_cups => @rerack_cups,
                        :extra_point_cups => @extra_point_cups,
    }}
    BW::HTTP.post(BaseURL + "/league/#{@commissioner.api_key}", {payload: data}) do |response|
      if response.ok?
        json = BW::JSON.parse(response.body.to_str)
        @id = json['id']
      else
        @error = 'Couldn\'t create league'
      end
      block.call
    end
  end
end
