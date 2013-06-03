class Team
  attr_accessor :id, :name, :players, :finalized, :proposed_at, :finalized_at, :season

  attr_accessor :error, :created

  def initialize
    @finalized = false
  end

  def create(&block)
    @created = false
    if valid_name?
      save(&block)
    else
      block.call
    end
  end

  private

  # validations
  def valid_name?
    @name.class == String && @name.length >= 2 && @name.length <= 20
  end

  def save(&block)
  end
end
