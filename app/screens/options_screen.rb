class OptionsScreen < ProMotion::Screen
  def did_load
    @reselect_league_button.when_tapped { dismiss_modal }
  end

  def will_appear
    navigationItem.title = 'Options'
    view.backgroundColor = BackgroundColor
  end
end
