class TurnScreen < PM::Screen
  attr_accessor :nav_stack, :turn, :num_shots, :undo_button, :skipped

  def viewDidLoad
    super
    navigationItem.title = "Round #{@turn.round.number+1}"
    if @skipped
      setup_skipped_turn
    else
      setup_playable_turn
    end
  end

  def setup_skipped_turn
    @turn.stub_untaken_shots
    @turn.finish!
    (0..2).each do |pos|
      darken_panel(pos)
      no_shot_for_panel(pos)
      @nav_stack.undo_button_locations << pos
    end
  end

  def viewDidAppear(animated)
    super(animated)
    if @skipped
      UIAlertView.alert "Balls Back!" do
        @nav_stack.push_next_turn_screen
      end
    end
  end

  def setup_playable_turn
    setup_hit_buttons
    setup_miss_buttons
    setup_undo_button
  end

  def viewWillAppear(animated)
    super(animated)
    @turn.round.game.current_turn = @turn unless navigationController.nil?
    if @turn.shots.count == @num_shots
      set_nav_bar_button :right, title: 'Done', action: :'done_editing', type: UIBarButtonItemStyleDone
    end
  end

  def done_editing
    @nav_stack.push_next_turn_screen
  end

  def back_to_previous_turn
    App.alert "Going back!"
  end

  def lighten_last_panel
    position = @nav_stack.undo_button_locations.last
    @panels[position].backgroundColor = :white.uicolor
    @names[position].textColor = :black.uicolor
    @hit_buttons[position].hidden = false
    @miss_buttons[position].hidden = false
    @hit_cup_labels[position].hidden = true
  end

  private

  def setup_hit_buttons
    @hit_buttons.each_with_index do |button, position|
      button.when_tapped do
        @nav_stack.undo_button_locations << position
        hit_for_player(position)
      end
    end
  end

  def setup_miss_buttons
    @miss_buttons.each_with_index do |button, position|
      button.when_tapped do
        @nav_stack.undo_button_locations << position
        miss_for_player(position)
      end
    end
  end

  def setup_undo_button
    @undo_button = layout(UIButton.custom, :undo_button) do end
    @undo_button.tap do |button|
      button.setTitle('Undo', forState:UIControlStateNormal)
      button.setTitleColor(:black.uicolor, forState:UIControlStateNormal)
      button.when_tapped do
        navigationItem.rightBarButtonItem = nil
        @nav_stack.undo_tapped
      end
    end
  end

  def hit_for_player(player_number)
    @turn.add_hit_for(player_number)
    adjust_panel(player_number, for: :hit)
    do_checks
  end

  def miss_for_player(player_number)
    @turn.add_miss_for(player_number)
    adjust_panel(player_number, for: :miss)
    do_checks
  end

  def do_checks
    remove_back_button
    check_for_end_of_game
    reposition_undo_button
    check_for_next_turn unless @turn.round.game.over?
  end

  def remove_back_button
    navigationItem.hidesBackButton = true
  end

  def check_for_end_of_game
    if @turn.round.game.over?
      verify_end_of_game
    end
  end

  def verify_end_of_game
    UIAlertView.alert("Game over?", buttons: ["Yes", "No! Undo"]) do |button|
      if button == 'Yes'
        @turn.stub_untaken_shots
        @turn.round.game.report!
        @nav_stack.end_game
      else
        @nav_stack.undo_tapped
      end
    end
  end

  def check_for_next_turn
    @nav_stack.push_next_turn_screen if @turn.over?
  end

  def reposition_undo_button
    panel_number = @nav_stack.undo_button_locations.last
    @panels[panel_number].addSubview(@undo_button)
    view.apply_constraints
  end

  def adjust_panel(number, for: action)
    darken_panel(number)
    if action == :hit
      hit_for_panel(number)
    else
      miss_for_panel(number)
    end
  end

  def darken_panel(number)
    @panels[number].backgroundColor = :black.uicolor
    @names[number].textColor = :white.uicolor
    @hit_buttons[number].hidden = true
    @miss_buttons[number].hidden = true
  end

  def hit_for_panel(number)
    @hit_cup_labels[number].text = @turn.round.game.cups_hit_by(@turn.team).to_s
    @hit_cup_labels[number].hidden = false
  end

  def miss_for_panel(number)
    @hit_cup_labels[number].text = '-'
    @hit_cup_labels[number].hidden = false
  end

  def no_shot_for_panel(number)
    @hit_cup_labels[number].text = 'no shot'
    @hit_cup_labels[number].hidden = false
  end
end
