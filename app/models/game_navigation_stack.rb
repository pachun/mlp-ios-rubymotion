class GameNavigationStack
  attr_accessor :nav, :game, :screens,
    :setup_screen, :undo_button_locations

  def initialize(game)
    @game = game
    @screens = []
    @undo_button_locations = []
    @setup_screen = GameSetupScreen.new
    @setup_screen.game = game
    @nav = UINavigationController.alloc.initWithRootViewController(@setup_screen)
  end

  def <<(screen)
    @screens << screen
    @nav << screen
  end

  def begin_with(team)
    SVProgressHUD.show
    @game.grab_big_gravatars do
      SVProgressHUD.dismiss
      @game.start_with(team)
      push_next_turn_screen
    end
  end

  def push_next_turn_screen
    if @screens.count == @nav.viewControllers.count - 1
      push_new_turn_screen
    else
      push_cached_turn_screen
    end
  end

  def push_cached_turn_screen
    position = @nav.viewControllers.count - 1
    @nav << @screens[position]
  end

  def push_new_turn_screen
    turn_screen = TurnScreen.new
    turn_screen.nav_stack = self
    turn_screen.turn = @game.next_turn
    turn_screen.num_shots = @game.season.league.players_per_team
    puts "in here"
    self << turn_screen
    puts "pushed turn onto VC"
  end

  def undo_tapped
    @game.undo_last_shot
    undo_ui_changes
  end

  def undo_ui_changes
    @nav.viewControllers.last.lighten_last_panel
    @undo_button_locations.pop
    reposition_undo_button
    unhide_back_button if no_turn_shots_taken?
  end

  def reposition_undo_button
    turn_screen = @nav.viewControllers.last
    turn_screen.undo_button.removeFromSuperview
    if wasnt_first_shot_of_turn?
      turn_screen.panels[@undo_button_locations.last].addSubview(turn_screen.undo_button)
    end
    turn_screen.view.apply_constraints
  end

  def wasnt_first_shot_of_turn?
    @undo_button_locations.count % @game.season.league.players_per_team != 0
  end

  def no_turn_shots_taken?
    players_per_team = @game.season.league.players_per_team
    @undo_button_locations.count % players_per_team == 0
  end

  def unhide_back_button
    @nav.viewControllers.last.navigationItem.hidesBackButton = false
  end
end
