class Game
  attr_accessor :id, :season, :scheduled_at, :scheduled_time, :winning_team_id, :was_played,
    :home_team, :away_team, :home_team_players, :away_team_players, :ref, :rounds, :turns
  attr_accessor :error, :created, :navigation_stack,
    :home_team_hits, :away_team_hits, :current_turn

  def initialize
    @rounds = []
    @home_team_hits = 0
    @away_team_hits = 0
    @home_team_players = []
    @away_team_players = []
  end

  def report!
    puts "Reporting game!!"
  end

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

  def setup_with_ref(ref)
    @ref = ref
    set_default_team_players
    @navigation_stack = GameNavigationStack.new(self)
  end

  def set_default_team_players
    @home_team_players = @home_team.players
    @away_team_players = @away_team.players
  end

  def grab_big_gravatars(&block)
    if all_big_gravatars_in?
      block.call
      return
    end
    grab_home_teams_big_gravatars(&block)
    grab_away_teams_big_gravatars(&block)
  end

  def start_with(team)
    @shooting_order = []
    @shooting_order << (team == :home_team ? @home_team : @away_team)
    @shooting_order << (team == :home_team ? @away_team : @home_team)
  end

  def next_turn
    if @rounds.last.nil? || @rounds.last.completed?
      @rounds << Round.new(self, @rounds.count, @shooting_order)
      @rounds.last.first_turn
    else
      @rounds.last.second_turn
    end
  end

  def undo_last_shot
    last_shot = @current_turn.shots.pop
    unless last_shot.cup_number == 0
      if @current_turn.team.id == @home_team.id
        @home_team_hits -= 1
      else
        @away_team_hits -= 1
      end
    end
  end

  def cups_hit_by(team)
    if team.id == @home_team.id
      @home_team_hits
    else
      @away_team_hits
    end
  end

  def increment_hits_for(team)
    if team.id == @home_team.id
      @home_team_hits += 1
      @home_team_hits
    else
      @away_team_hits += 1
      @away_team_hits
    end
    1
  end

  def over?
    @home_team_hits == 4 || @away_team_hits == 4
  end

  private

  def grab_home_teams_big_gravatars(&block)
    @home_team_players.each do |player|
      player.grab_big_gravatar do
        block.call if all_big_gravatars_in?
      end
    end
  end

  def grab_away_teams_big_gravatars(&block)
    @away_team_players.each do |player|
      player.grab_big_gravatar do
        block.call if all_big_gravatars_in?
      end
    end
  end

  def all_big_gravatars_in?
    @home_team_players.each do |player|
      return false if player.big_gravatar.nil?
    end
    @away_team_players.each do |player|
      return false if player.big_gravatar.nil?
    end
    true
  end

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
