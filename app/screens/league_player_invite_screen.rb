class LeaguePlayerInviteScreen < ProMotion::Screen
  attr_accessor :signedin_player, :league

  title 'League Invite'

  def did_load
    @accept_button.when_tapped { confirm_accept }
    @decline_button.when_tapped { confirm_decline }
  end

  private

  def confirm_accept
    UIAlertView.alert("Join #{@league.name}?", buttons: ['Yes, Accept!', 'No']) do |button|
      accept_invitation if button != 'No'
    end
  end

  def confirm_decline
    UIAlertView.alert("Decline #{@league.name} invite?", buttons: ['Yes', 'Woops, No!']) do |button|
      decline_invitation if button == 'Yes'
    end
  end

  def accept_invitation
    @signedin_player.accept_league_invitation(@league) do
      if @signedin_player.accepted_invite
        SVProgressHUD.showSuccessWithStatus("Joined #{@league.name}!")
        navigationController.pop
      else
        SVProgressHUD.showErrorWithStatus("Unable to join #{@league.name}!")
      end
    end
  end

  def decline_invitation
    @signedin_player.decline_league_invitation(@league) do
      if @signedin_player.declined_invite
        SVProgressHUD.showSuccessWithStatus('Invite discarded!')
        navigationController.pop
      else
        SVProgressHUD.showErrorWithStatus('Uh oh. This invite is impervious to deletion!')
      end
    end
  end
end
