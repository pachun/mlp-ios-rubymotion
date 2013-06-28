class GameNavigationStack
  attr_accessor :nav, :game,
    :setup_screen

  def initialize(game)
    @game = game
    @setup_screen = GameSetupScreen.new
    @setup_screen.game = game
    @nav = UINavigationController.alloc.initWithRootViewController(@setup_screen)
  end
end
