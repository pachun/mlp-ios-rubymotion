class CreateTeamScreen < ProMotion::Screen
  attr_accessor :league, :creater, :player2, :player3, :selecting_player

  title 'New Team'

  def did_load
    view.when_tapped { drop_keyboard }
    @name_field.when(DoneWithKeyboard) { drop_keyboard }
    @player2_icon.when_tapped { @selecting_player = 2; select_player }
    @player3_icon.when_tapped { @selecting_player = 3; select_player } if @league.players_per_team == 3
    @invite_button.when_tapped { create_team }
  end

  def on_return(args = {})
    if @selecting_player == 2
      self.player2 = args[:selected_player]
    else
      self.player3 = args[:selected_player]
    end
  end

  def player2=(player2)
    @player2 = player2
    puts "resetting player 2"
    @player2_name.text = player2.name
    @player2_icon.image = player2.gravatar
  end

  def player3=(player3)
    @player3 = player3
    puts "resetting player 3"
    @player3_name.text = player3.name
    @player3_icon.image = player3.gravatar
  end

  private

  def select_player
    selection_exclusions = [@creater, (selecting_player == 2 ? @player3 : @player2)]
    open TeammateInviteScreen.new(league: league, excluded_players: selection_exclusions)
  end

  def drop_keyboard
    @name_field.resignFirstResponder
  end

  def create_team
  end
end
