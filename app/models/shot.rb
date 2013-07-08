class Shot
  attr_accessor :id, :turn, :player, :shot_at, :cup_number, :status

  def initialize(turn, player, status, cup_number)
    @turn = turn
    @player = player
    @status = status
    @cup_number = cup_number
    @shot_at = NSDate.new
  end
end
