Teacup::Stylesheet.new(:options_sheet) do
  import :mlp

  style :root,
    backgroundColor: BackgroundColor

  style :reselect_league_button, extends: :blue_button,
    constraints: [
      constrain_width(ControlWidth),
      constrain_height(ButtonHeight),
      constrain(:center_x).equals(:superview, :center_x),
      constrain(:bottom).equals(:superview, :bottom).minus(15),
    ]
end
