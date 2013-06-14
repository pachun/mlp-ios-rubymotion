class GameSetupScreen < ProMotion::Screen
  attr_accessor :game

  def viewDidLoad
    super
    self.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal
  end

  def will_appear
    navigationItem.title = "#{@game.home_team.name} vs #{@game.away_team.name}"
    navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemTrash, target:self, action: :confirm_quit)
  end

  def confirm_quit
    UIAlertView.alert('Are you sure? All recorded stats will be discarded.', buttons: ['Yes, Quit', 'Woops, No!']) do |button|
      dismiss_modal if button == 'Yes, Quit'
    end
  end
end
