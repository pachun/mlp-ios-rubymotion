class TeamInvitationScreen < UIViewController
  attr_accessor :accept_button, :decline_button
  stylesheet :team_invitation_sheet

  layout :root do
    subview(UILabel, :team_name, :text => @team.name)
    subview(UIImageView, :player1_icon, :image => @team.players[0].gravatar)
    subview(UILabel, :player1_name, :text => @team.players[0].name)
    subview(UIImageView, :player2_icon, :image => @team.players[1].gravatar)
    subview(UILabel, :player2_name, :text => @team.players[1].name)
    if @team.season.league.players_per_team == 3
      subview(UIImageView, :player3_icon, :image => @team.players[2].gravatar)
      subview(UILabel, :player3_name, :text => @team.players[2].name)
    end
    if !@team.has_response_for(@signedin_player) && !@team.nullified? && !@team.season.teams_locked
      @accept_button = subview(UIButton.custom, :accept_button)
      @decline_button = subview(UIButton.custom, :decline_button)
    end
  end

  def layoutDidLoad
    if !@team.has_response_for(@signedin_player) && !@team.nullified? && !@team.season.teams_locked
      @accept_button.setTitle('Accept', forState:UIControlStateNormal)
      @accept_button.setTitleColor(:white.uicolor, forState:UIControlStateNormal)
      @decline_button.setTitle('Decline', forState:UIControlStateNormal)
      @decline_button.setTitleColor(:white.uicolor, forState:UIControlStateNormal)
    end
  end
end
