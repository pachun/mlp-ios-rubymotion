class OptionsScreen < ProMotion::Screen
  attr_accessor :league, :signedin_player

  def did_load
    @reselect_league_button.when_tapped { dismiss_modal }
    @invite_players_button.when_tapped { invite_players } if i_am_commissioner?
  end

  def will_appear
    navigationItem.title = 'Options'
    view.backgroundColor = BackgroundColor
  end

  def done_with_invitations
    navigationController.pop self
  end

  private

  def i_am_commissioner?
    @signedin_player.id == @league.commissioner.id
  end

  def invite_players
    @league.populate_invitable_players(@signedin_player) do
      open InvitePlayersToLeagueScreen.new(league: @league, signedin_player: @signedin_player, delegate: self)
    end
  end
end
