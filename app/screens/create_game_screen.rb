class CreateGameScreen < Formotion::FormController
  include ProMotion::ScreenModule

  def viewWillAppear(animated)
    super(animated)
    navigationItem.title = 'New Game'
  end
end
