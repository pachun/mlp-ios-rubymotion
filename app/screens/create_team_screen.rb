class CreateTeamScreen < ProMotion::Screen
  attr_accessor :league, :creater, :teammate1, :teammate2, :selecting_teammate

  title 'New Team'

  def did_load
    view.when_tapped { drop_keyboard }
    @name_field.when(DoneWithKeyboard) { drop_keyboard }
    @teammate1_icon.when_tapped { @selecting_teammate = 1; select_teammate }
    @teammate2_icon.when_tapped { @selecting_teammate = 2; select_teammate } if @league.players_per_team == 3
    @invite_button.when_tapped { create_team }
  end

  def on_return(args = {})
    if @selecting_teammate == 1
      self.teammate1 = args[:teammate]
    else
      self.teammate2 = args[:teammate]
    end
  end

  def teammate1=(teammate1)
    @teammate1 = teammate1
    @teammate1_name.text = teammate1.name
    @teammate1_icon.image = teammate1.gravatar
  end

  def teammate2=(teammate2)
    @teammate2 = teammate2
    @teammate2_name.text = teammate2.name
    @teammate2_icon.image = teammate2.gravatar
  end

  private

  def select_teammate
    selection_exclusions = [@creater, (selecting_teammate == 1 ? @teammate2 : @teammate1)]
    open TeammateInviteScreen.new(league: league, excluded_players: selection_exclusions)
  end

  def drop_keyboard
    @name_field.resignFirstResponder
  end
end
