class PlayerDetailsScreen < ProMotion::Screen
  attr_accessor :player

  def viewDidLoad
    super
    navigationItem.title = @player.name
  end
end
