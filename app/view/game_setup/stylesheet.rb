Teacup::Stylesheet.new(:game_setup_sheet) do
  import :mlp

  style :root,
    background: BackgroundColor

  style :home_team_bg,
    constraints: [
      constrain(:left).equals(:superview, :left),
      constrain(:center_y).equals(:superview, :center_y),
      constrain(:height).equals(:superview, :height),
      constrain(:width).equals(:superview, :width).times(0.5),
    ]

  style :away_team_bg,
    constraints: [
      constrain(:right).equals(:superview, :right),
      constrain(:center_y).equals(:superview, :center_y),
      constrain(:width).equals(:superview, :width).times(0.5),
      constrain(:height).equals(:superview, :height),
    ]

  style :player_icon,
    layer: {
      masksToBounds: true,
      cornerRadius: 30,
    }

  style :player1_icon, extends: :player_icon,
    constraints: [
      constrain_width(60),
      constrain_height(60),
      constrain(:center_y).equals(:superview, :center_y),
      constrain(:center_x).equals(:superview, :center_x).minus(70),
    ]

  style :player2_icon, extends: :player_icon,
    constraints: [
      constrain_width(60),
      constrain_height(60),
      constrain(:center_y).equals(:superview, :center_y),
      constrain(:center_x).equals(:superview, :center_x).plus(70),
    ]

  style :player3_icon, extends: :player_icon,
    constraints: [
      constrain_width(60),
      constrain_height(60),
      constrain(:center_y).equals(:superview, :center_y).minus(90),
      constrain(:center_x).equals(:superview, :center_x),
    ]

  style :player_name,
    font: :bold.uifont(14),
    background: :clear.uicolor,
    textAlignment: :center.uialignment

  style :player1_name, extends: :player_name,
    constraints: [
      constrain_below(:player1_icon),
      constrain(:center_x).equals(:player1_icon, :center_x),
    ]

  style :player2_name, extends: :player_name,
    constraints: [
      constrain_below(:player2_icon),
      constrain(:center_x).equals(:player2_icon, :center_x),
    ]

  style :player3_name, extends: :player_name,
    constraints: [
      constrain_below(:player3_icon),
      constrain(:center_x).equals(:player3_icon, :center_x),
    ]

  style :start_button, extends: :red_button,
    constraints: [
      constrain_width(ControlWidth),
      constrain_height(ButtonHeight),
      constrain(:center_x).equals(:superview, :center_x),
      constrain(:bottom).equals(:superview, :bottom).minus(10),
    ]
end
