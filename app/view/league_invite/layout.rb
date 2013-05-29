class LeaguePlayerInviteScreen < ProMotion::Screen
  stylesheet :league_player_invite_sheet

  layout :root do
    ppt = @league.players_per_team
    no_balls_back = !@league.plays_balls_back
    reracks = @league.rerack_cups.split(',').join(' & ')
    subview(UILabel, :cordial_invite_label)
    subview(UILabel, :league_name, :text => @league.name)
    subview(UILabel, :commissioner_title)
    subview(UILabel, :commissioner_name, :text => league.commissioner.name)
    subview(UILabel, :players_per_team, :text => "#{ppt} vs #{ppt}")
    subview(UILabel, :balls_back, :text => "#{'No ' if no_balls_back}Balls Back")
    if reracks.length > 0
      subview(UILabel, :rerack_cups, :text => "Reracks @ #{reracks}")
    else
      subview(UILabel, :rerack_cups, :text => "No Reracks")
    end
    @accept_button = subview(UIButton.custom, :accept_button)
    @decline_button = subview(UIButton.custom, :decline_button)
  end

  def layoutDidLoad
    @accept_button.setTitle('Accept', forState:UIControlStateNormal)
    @accept_button.setTitleColor(:white.uicolor, forState:UIControlStateNormal)
    @decline_button.setTitle('Decline', forState:UIControlStateNormal)
    @decline_button.setTitleColor(:white.uicolor, forState:UIControlStateNormal)
    did_load
  end
end
