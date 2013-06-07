Teacup::Stylesheet.new(:team_invitation_sheet) do
  import :mlp

  style :root,
    background: BackgroundColor

  style :team_name,
    font: 'Satisfy'.uifont(30),
    background: :clear.uicolor,
    textAlignment: :center.uialignment,
    constraints: [
      constrain_width(200),
      constrain(:top).equals(:superview, :top).plus(35),
      constrain(:center_x).equals(:superview, :center_x),
    ]

  style :player_icon,
    layer: {
      masksToBounds: true,
      cornerRadius: 25,
    }

  style :player_name,
    font: :bold.uifont(14),
    background: :clear.uicolor,
    textAlignment: :center.uialignment

  style :player3_icon, extends: :player_icon,
    constraints: [
      constrain_width(50),
      constrain_height(50),
      constrain_below(:team_name, 12),
      constrain(:center_x).equals(:superview, :center_x),
    ]

  style :player3_name, extends: :player_name,
    constraints: [
      constrain_below(:player3_icon, 2),
      constrain_width(ControlWidth),
      constrain(:center_x).equals(:superview, :center_x),
    ]

  style :player1_icon, extends: :player_icon,
    constraints: [
      constrain_width(50),
      constrain_height(50),
      constrain_below(:team_name, 85),
      constrain(:right).equals(:superview, :center_x).minus(45),
    ]

  style :player1_name, extends: :player_name,
    constraints: [
      constrain_below(:player1_icon, 2),
      constrain_width(ControlWidth),
      constrain(:center_x).equals(:player1_icon, :center_x),
    ]

  style :player2_icon, extends: :player_icon,
    constraints: [
      constrain_width(50),
      constrain_height(50),
      constrain_below(:team_name, 85),
      constrain(:left).equals(:superview, :center_x).plus(45),
    ]

  style :player2_name, extends: :player_name,
    constraints: [
      constrain_below(:player2_icon, 2),
      constrain_width(ControlWidth),
      constrain(:center_x).equals(:player2_icon, :center_x),
    ]

  style :accept_button, extends: :red_button,
    constraints: [
      constrain_width(ControlWidth),
      constrain_height(ButtonHeight),
      constrain_above(:decline_button, 15),
      constrain(:center_x).equals(:superview, :center_x),
    ]

  style :decline_button, extends: :blue_button,
    constraints: [
      constrain_width(ControlWidth),
      constrain_height(ButtonHeight),
      constrain(:center_x).equals(:superview, :center_x),
      constrain(:bottom).equals(:superview, :bottom).minus(15),
    ]
end
