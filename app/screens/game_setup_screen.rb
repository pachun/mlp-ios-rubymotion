class GameSetupScreen < ProMotion::Screen
  attr_accessor :game, :subing_team, :subing_player

  def viewDidLoad
    super
    self.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal
  end

  def viewDidLoad
    super
    navigationItem.title = "#{@game.home_team.name} vs #{@game.away_team.name}"
    navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemTrash, target:self, action: :confirm_quit)
    allow_player_substitutions
  end

  def allow_player_substitutions
    @home_player_icons.each_with_index do |icon, position|
      icon.when_tapped { select(:home_team, sub_for: position) }
    end
    @away_player_icons.each_with_index do |icon, position|
      icon.when_tapped { select(:away_team, sub_for: position) }
    end
  end

  def on_return(args = {})
    if @subing_team == :home_team
      @game.home_team_players[@subing_player] = args[:player]
    else
      @game.away_team_players[@subing_player] = args[:player]
    end
    update_team_players
  end

  private

  def update_team_players
    @home_player_icons.each_with_index do |icon, position|
      icon.image = @game.home_team_players[position].gravatar
    end
    @home_player_names.each_with_index do |name_label, position|
      name_label.text = @game.home_team_players[position].name
    end
    @away_player_icons.each_with_index do |icon, position|
      icon.image = @game.away_team_players[position].gravatar
    end
    @away_player_names.each_with_index do |name_label, position|
      name_label.text = @game.away_team_players[position].name end
  end

  def confirm_quit
    UIAlertView.alert('Are you sure? All recorded stats will be discarded.', buttons: ['Yes, Quit', 'Woops, No!']) do |button|
      dismiss_modal if button == 'Yes, Quit'
    end
  end

  def select(team, sub_for:player_position)
    @subing_team = team
    @subing_player = player_position
    ommitted_ids = game.home_team_players.map { |p| p.id } + game.away_team_players.map { |p| p.id }
    open SubstitutePlayerScreen.new(league: @game.season.league, scorer: @game.ref, ommitted_player_ids: ommitted_ids)
  end
end
