class Season
  attr_accessor :id, :created_at, :name, :teams_locked,
    :league, :teams, :games

  attr_accessor :error, :created

  def self.from_hash(season_hash, with_league:league)
    season = Season.new
    season.league = league
    season.id = season_hash[:id] if season_hash.has_key?(:id)
    season.name = season_hash[:name] if season_hash.has_key?(:name)
    season.teams_locked = season_hash[:teams_locked] if season_hash.has_key?(:teams_locked)
    season.created_at = season_hash[:created_at] if season_hash.has_key?(:created_at)
    season
  end

  def create(&block)
    @created = false
    if valid_name?
      save(&block)
    else
      block.call
    end
  end

  def team_with_id(id)
    @teams.select{|team| team.id == id}.first
  end

  def player_with_id(id)
    @league.players.select{|player| player.id == id}.first
  end

  def populate_teams(player, &block)
    BW::HTTP.get(BaseURL + "/season/#{@id}/teams/#{player.api_key}") do |response|
      team_hashes = BW::JSON.parse(response.body.to_str)
      @teams = team_hashes.map { |team_json| Team.from_hash(team_json, with_season:self) }
      block.call
    end
  end

  def populate_games(player, &block)
    BW::HTTP.get(BaseURL + "/season/#{@id}/games/#{player.api_key}") do |response|
      game_hashes = BW::JSON.parse(response.body.to_str)
      @games = game_hashes.map { |game_json| Game.from_hash(game_json, with_season:self) }
      block.call
    end
  end

  def lock_teams(player, &block)
    BW::HTTP.put(BaseURL + "/season/#{@id}/lock_teams/#{player.api_key}") do |response|
      @teams_locked = true if response.ok?
      block.call
    end
  end

  private

  def valid_name?
    if @name.class == String && @name.length >= 2 && @name.length <= 20
      true
    else
      @error = 'Names are 2-20 long'
      false
    end
  end

  def save(&block)
    data = {:season => {:name => @name,
                        :league_id => @league.id
    }}
    BW::HTTP.post(BaseURL + "/season/#{@league.commissioner.api_key}", {payload: data}) do |response|
      if response.ok?
        json = BW::JSON.parse(response.body.to_str)
        @id = json[:id]
        @teams_locked = json[:teams_locked]
        @created_at = json[:created_at]
        @created = true
      else
        @error = 'Couldn\'t create season'
      end
      block.call
    end
  end
end
