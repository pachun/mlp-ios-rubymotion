class LeaguePlayerInviteScreen < ProMotion::Screen
  attr_accessor :league, :accept_button, :decline_button

  title 'League Invite'

  def did_load
    @accept_button.when_tapped { confirm_accept }
    @decline_button.when_tapped { confirm_decline }
  end

  private

  def confirm_accept
    puts "confirming accept"
  end

  def confirm_decline
    puts "confirming decline"
  end
end
