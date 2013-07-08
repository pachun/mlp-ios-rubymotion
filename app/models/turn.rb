class Turn
  attr_accessor :round, :team, :id, :started_at, :playable, :finished_at, :shots

  def initialize(round, team)
    @shots = []
    @team = team
    @round = round
    @playable = true
  end

  def add_hit_for(player_number)
    player = @team.players[player_number]
    @shots << Shot.new(self, player, :shot, @round.game.increment_hits_for(@team))
  end

  def add_miss_for(player_number)
    player = @team.players[player_number]
    @shots << Shot.new(self, player, :shot, 0)
  end

  def over?
    if @round.game.season.league.players_per_team == @shots.count
      @finished_at = NSDate.new
      true
    else
      false
    end
  end

  def stub_untaken_shots
  end
end
