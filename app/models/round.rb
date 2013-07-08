class Round
  attr_accessor :game, :id, :started_at, :number,
    :first_turn, :second_turn, :shooting_order

  def initialize(game, number, shooting_order)
    @game = game
    @number = number
    @started_at = NSDate.new
    @first_turn = Turn.new(self, shooting_order[0])
    @second_turn = Turn.new(self, shooting_order[1])
  end

  def completed?
    @first_turn.finished_at && @second_turn.finished_at
  end
end
