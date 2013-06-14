class GameSetupScreen < ProMotion::Screen
  attr_accessor :game, :subing_team

  def viewDidLoad
    super
    self.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal
  end

  def will_appear
    navigationItem.title = "#{@game.home_team.name} vs #{@game.away_team.name}"
    navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemTrash, target:self, action: :confirm_quit)
    @home_player_icons.each_with_index do |icon, position|
      icon.when_tapped { select(:home_team, sub_for: position) }
    end
    @away_player_icons.each_with_index do |icon, position|
      icon.when_tapped { select(:away_team, sub_for: position) }
    end
  end

  def on_return(args = {})
    puts "got #{args.inspect}"
  end

  private

  def confirm_quit
    UIAlertView.alert('Are you sure? All recorded stats will be discarded.', buttons: ['Yes, Quit', 'Woops, No!']) do |button|
      dismiss_modal if button == 'Yes, Quit'
    end
  end

  def select(team, sub_for:player_position)
    @subing_team = team
    ommitted_ids = game.home_team.players.map { |p| p.id } + game.away_team.players.map { |p| p.id }
    open SubstitutePlayerScreen.new(league: @game.season.league, scorer: @game.ref, ommitted_player_ids: ommitted_ids)
  end
end
