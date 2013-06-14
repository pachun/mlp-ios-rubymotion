class OptionsScreen < ProMotion::Screen
  attr_accessor :reselect_league_button

  stylesheet :options_sheet

  layout :root do
    @reselect_league_button = subview(UIButton.custom, :reselect_league_button)
  end

  def layoutDidLoad
    @reselect_league_button.setTitle('Repick League', forState:UIControlStateNormal)
    @reselect_league_button.setTitleColor(:white.uicolor, forState:UIControlStateNormal)
    did_load
  end
end
