class Game
  attr_accessor :id, :season, :scheduled_at, :scheduled_time, :winning_team_id, :was_played,
    :home_team, :away_team, :home_team_players, :away_team_players
  attr_accessor :error, :created

  def self.from_hash(game_hash, with_season: season)
    game = Game.new
    game.id = game_hash[:id]
    game.season = season
    game.scheduled_at = game_hash[:scheduled_at]
    game.scheduled_time = game_hash[:scheduled_time]
    game.was_played = game_hash[:was_played]
    game.winning_team_id = game_hash[:winning_team_id]
    game.home_team = season.team_with_id(game_hash[:home_team_id])
    game.away_team = season.team_with_id(game_hash[:away_team_id])
    if game.was_played
      # set home/away team players here
    end
    game
  end

  def create(commissioner, &block)
    @created = false
    if valid_schedule_time? && valid_home_team? && valid_away_team? && different_teams?
      save(commissioner, &block)
    else
      block.call
    end
  end

  private

  def valid_schedule_time?
    if @scheduled_time.nil?
      @error = 'Set a date & time!'
      false
    else
      true
    end
  end

  def valid_home_team?
    if @home_team.nil?
      @error = 'Set a home team!'
      false
    else
      true
    end
  end

  def valid_away_team?
    if @away_team.nil?
      @error = 'Set an away team!'
      false
    else
      true
    end
  end

  def different_teams?
    if @home_team.id == @away_team.id
      @error = 'Select different teams'
      false
    else
      true
    end
  end

  def save(commissioner, &block)
    data = {:game => {:season_id => @season.id,
                      :scheduled_time => Time.at(@scheduled_time),
                      :home_team_id => @home_team.id,
                      :away_team_id => @away_team.id,
    }}
    BW::HTTP.post(BaseURL + "/game/#{commissioner.api_key}", {payload: data}) do |response|
      if response.ok?
        @created = true
        block.call
      else
        @error = 'Couldn\'t create game'
        block.call
      end
    end
    block.call
  end
end
