class Turn
  attr_accessor :round, :team, :id, :started_at, :finished_at, :shots

  def self.from_hash(turn, in_round:round)
    new_turn = Turn.new(round, round.game.season.team_with_id(turn['team_id']))
    new_turn.id = turn['id']
    new_turn.started_at = turn['started_at']
    turn['shots'].each do |shot|
      new_turn.shots << Shot.from_hash(shot, in_turn:new_turn)
    end
    new_turn
  end

  def jsonify
    @started_at = NSDate.new if @started_at.nil?
    json = {
      :started_at => @started_at.to_s,
      :team_id => @team.id,
    }
    json[:shots] = @shots.map { |s| s.jsonify }
    json
  end

  def initialize(round, team)
    @shots = []
    @team = team
    @round = round
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

  def shot_for(player)
    @shots.select{ |shot|
      shot.player.id == player.id }.first
  end

  def cup_hit_by(player)
    shot = shot_for(player)
    if shot.status == 'shot' && shot.cup_number != 0
      shot.cup_number.to_s
    elsif shot.status == 'shot' && shot.cup_number == 0
      '-'
    else
      "no shot"
    end
  end
end
