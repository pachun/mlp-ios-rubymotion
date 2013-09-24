class OptionsScreen < ProMotion::Screen
  attr_accessor :reselect_league_button

  stylesheet :options_sheet

  layout :root do
    @reselect_league_button = subview(UIButton.custom, :reselect_league_button)
    if i_am_commissioner?
      @invite_players_button = subview(UIButton.custom, :invite_players_button)
    end
  end

  def layoutDidLoad
    @reselect_league_button.setTitle('Repick League', forState:UIControlStateNormal)
    @reselect_league_button.setTitleColor(:white.uicolor, forState:UIControlStateNormal)
    if i_am_commissioner?
      @invite_players_button.setTitle('Invite Players', forState:UIControlStateNormal)
      @invite_players_button.setTitleColor(:white.uicolor, forState:UIControlStateNormal)
    end
    did_load
  end
end
