class Round
  attr_accessor :game, :id, :started_at, :number,
    :first_turn, :second_turn, :shooting_order

  def jsonify
    {
      :started_at => @started_at.to_s,
      :number => @number,
      :first_turn => @first_turn.jsonify,
      :second_turn => @second_turn.jsonify,
    }
  end

  def self.from_hash(round, in_game:game)
    new_round = Round.new(game, round['number'], nil)
    new_round.id = round['id']
    new_round.started_at = round['started_at']
    new_round.first_turn = Turn.from_hash(round['first_turn'], in_round:new_round)
    new_round.second_turn = Turn.from_hash(round['second_turn'], in_round:new_round) unless round['second_turn'].nil?
    new_round
  end

  def initialize(game, number, shooting_order)
    @game = game
    @number = number
    @started_at = NSDate.new
    if shooting_order
      @first_turn = Turn.new(self, shooting_order[0])
      @second_turn = Turn.new(self, shooting_order[1])
    end
  end

  def completed?
    @first_turn.finished_at && @second_turn.finished_at
  end
end
