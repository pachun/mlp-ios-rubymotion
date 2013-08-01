class Shot
  attr_accessor :id, :turn, :player, :shot_at, :cup_number, :status

  def self.from_hash(shot, in_turn:turn)
    new_shot = Shot.new(
      turn,
      turn.round.game.season.player_with_id(shot['player_id']),
      shot['status'],
      shot['cup_number'],
    )
    new_shot.shot_at = shot['shot_at']
    new_shot
  end

  def initialize(turn, player, status, cup_number)
    @turn = turn
    @player = player
    @status = status
    @cup_number = cup_number
    @shot_at = NSDate.new
  end

  def jsonify
    {
      :player_id => @player.id,
      :status => @status,
      :shot_at => @shot_at.to_s,
      :cup_number => @cup_number,
    }
  end
end
