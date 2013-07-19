class GameNavigationStack
  attr_accessor :nav, :game, :screens,
    :setup_screen, :undo_button_locations,
    :skip_next_turn

  def initialize(game)
    @game = game
    @screens = []
    @skip_next_turn = false
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

  def end_game
    # current_turn.team = winner
  end

  def about_to_start_first_turn?
    @nav.viewControllers.count == 1 # setup screen
  end

  def everyone_hit_cups_last_turn?
    return false if about_to_start_first_turn?
    hit_shots = current_turn.shots.select { |shot| shot.cup_number > 0 }
    hit_shots.count == @game.season.league.players_per_team
  end

  def current_turn
    overall_turn_index = @nav.viewControllers.count - 2
    round_number = overall_turn_index / 2
    if overall_turn_index % 2 == 0
      @game.rounds[round_number].first_turn
    else
      @game.rounds[round_number].second_turn
    end
  end

  def push_next_turn_screen
    if everyone_hit_cups_last_turn? && @game.season.league.plays_balls_back
      @skip_next_turn = true
    end
    if need_new_turn_screen?
      push_new_turn_screen
    else
      push_cached_turn_screen
    end
  end

  def need_new_turn_screen?
    @screens.count == @nav.viewControllers.count - 1 # for setup screen
  end

  def push_cached_turn_screen
    position = @nav.viewControllers.count - 1
    turn_screen = @screens[position]
    skip?(turn_screen)
    @nav << turn_screen
  end

  def push_new_turn_screen
    turn_screen = TurnScreen.new
    turn_screen.nav_stack = self
    turn_screen.turn = @game.next_turn
    turn_screen.num_shots = @game.season.league.players_per_team
    skip?(turn_screen)
    self << turn_screen
  end

  def skip?(turn_screen)
    if @skip_next_turn
      turn_screen.skipped = true
      @skip_next_turn = false
    end
  end

  def undo_tapped
    @game.undo_last_shot
    undo_ui_changes
  end

  def undo_ui_changes
    @nav.viewControllers.last.lighten_last_panel
    @undo_button_locations.pop
    reposition_undo_button
    unhide_nav_back_button if no_turn_shots_taken?
  end

  def reposition_undo_button
    remove_undo_button
    replace_previous_undo_button unless is_first_shot_of_turn?
  end

  def replace_previous_undo_button
    turn_screen = @nav.viewControllers.last
    turn_screen.panels[@undo_button_locations.last].addSubview(turn_screen.undo_button)
    turn_screen.view.apply_constraints
  end

  def remove_undo_button
    turn_screen = @nav.viewControllers.last
    turn_screen.undo_button.removeFromSuperview
  end

  def is_first_shot_of_turn?
    @undo_button_locations.count % @game.season.league.players_per_team == 0
  end

  def no_turn_shots_taken?
    players_per_team = @game.season.league.players_per_team
    @undo_button_locations.count % players_per_team == 0
  end

  def unhide_nav_back_button
    @nav.viewControllers.last.navigationItem.hidesBackButton = false
  end
end
