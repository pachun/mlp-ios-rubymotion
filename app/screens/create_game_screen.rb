class CreateGameScreen < Formotion::FormController
  include ProMotion::ScreenModule

  def viewWillAppear(animated)
    super(animated)
    navigationItem.title = 'New Game'
    navigationItem.leftBarButtonItem = UIBarButtonItem.alloc.initWithImage('back_arrow.png'.uiimage, style:UIBarButtonItemStylePlain, target:self, action: :go_back_to_games_screen)
  end

  def go_back_to_games_screen
    dismiss_modal
  end
end
