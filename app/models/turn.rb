class Turn
  attr_accessor :round, :team, :id, :started_at, :playable, :finished_at, :shots

  def initialize(round, team)
    @shots = []
    @team = team
    @round = round
    @playable = true
  end

  def add_hit_for(player_number)
    @started_at ||= NSDate.new
    player = @team.players[player_number]
    @shots << Shot.new(self, player, :shot, @round.game.increment_hits_for(@team))
  end

  def add_miss_for(player_number)
    @started_at ||= NSDate.new
    player = @team.players[player_number]
    @shots << Shot.new(self, player, :shot, 0)
  end

  def stub_untaken_shots
    if @team.players.count > @shots.count
      shot_player_ids = @shots.map{|s| s.player.id}
      unshot_players = @team.players.select{|p| !shot_player_ids.include?(p.id)}
      unshot_players.each do |player|
        @shots << Shot.new(self, player, :no_shot, 0)
      end
    end
  end

  def over?
    if @round.game.season.league.players_per_team == @shots.count
      finish!
      true
    else
      false
    end
  end

  def finish!
    @finished_at = NSDate.new
  end
end
