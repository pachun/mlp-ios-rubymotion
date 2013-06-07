class TeamInvitationScreen < UIViewController
  attr_accessor :signedin_player, :team, :rejected_team

  def viewDidLoad
    super
    navigationItem.title = ''
    if !@team.has_response_for(@signedin_player) && !@team.nullified? && !@team.season.teams_locked
      @accept_button.when_tapped { confirm_accept }
      @decline_button.when_tapped { confirm_decline }
    end
  end

  def confirm_accept
    UIAlertView.alert("Join #{@team.name}?", buttons: ['Yes, Accept!', 'No']) do |button|
      confirm_potential_team_rejections if button != 'No'
    end
  end

  def confirm_potential_team_rejections
    if @signedin_player.accepted_another_unrejected_team?
      @rejected_team = @signedin_player.accepted_and_unrejected_team
      UIAlertView.alert("This will undo your acceptance of #{team.name}'s invitation'?", buttons: ['Accept Anyway', 'Don\'t Accept']) do |button|
        @signedin_player.decline_team_invitation(@rejected_team) { accept_invitation } if button == 'Accept Anyway'
      end
    else
      accept_invitation
    end
  end

  def confirm_decline
    UIAlertView.alert("Decline #{@team.name} team invitation?", buttons: ['Yes', 'Woops, No!']) do |button|
      decline_invitation if button == 'Yes'
    end
  end

  def accept_invitation
    @signedin_player.accept_team_invitation(@team) do
      if @signedin_player.accepted_invite
        SVProgressHUD.showSuccessWithStatus("Accepted #{@team.name}!")
        navigationController.pop
      else
        SVProgressHUD.showErrorWithStatus("Unable to join #{@team.name}!")
      end
    end
  end

  def decline_invitation
    @signedin_player.decline_team_invitation(@team) do
      if @signedin_player.declined_invite
        SVProgressHUD.showSuccessWithStatus("Invite rejected!")
        navigationController.pop
      else
        SVProgressHUD.showErrorWithStatus('Uh oh. This invite is impervious to deletion!')
      end
    end
  end
end
