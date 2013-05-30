class LeaguePlayerInviteScreen < ProMotion::Screen
  attr_accessor :player, :league, :accept_button, :decline_button

  title 'League Invite'

  def did_load
    @accept_button.when_tapped { confirm_accept }
    @decline_button.when_tapped { confirm_decline }
  end

  private

  def confirm_accept
    UIAlertView.alert("Join #{@league.name}?", buttons: ['Yes, Accept!', 'No']) do |button|
      if button != 'No'
        @player.accept_league_invitation(@league) do
          if @player.accepted_invite
            SVProgressHUD.showSuccessWithStatus("Joined #{@league.name}!")
            navigationController.pop
          else
            SVProgressHUD.showErrorWithStatus("Unable to join #{@league.name}!")
          end
        end
      end
    end
  end

  def confirm_decline
    UIAlertView.alert("Decline #{@league.name} invite?", buttons: ['Yes', 'Woops, No!']) do |button|
      if button == 'Yes'
        @player.decline_league_invitation(@league) do
          if @player.declined_invite
            SVProgressHUD.showSuccessWithStatus("Invite discarded!")
            navigationController.pop
          else
            SVProgressHUD.showErrorWithStatus("Uh oh. This invite is impervious to deletion!")
          end
        end
      end
    end
  end
end
