Teacup::Stylesheet.new(:league_player_invite_sheet) do
  import :mlp

  style :root,
    background: BackgroundColor

  style :cordial_invite_label,
    text: 'You are cordially invited to join league',
    numberOfLines: 3,
    font: 'Satisfy'.uifont(20),
    background: :clear.uicolor,
    textAlignment: :center.uialignment,
    constraints: [
      constrain_width(200),
      constrain_height(60),
      constrain(:center_x).equals(:superview, :center_x),
      constrain(:top).equals(:superview, :top).plus(20),
    ]

  style :league_name,
    font: 'Satisfy'.uifont(36),
    background: :clear.uicolor,
    textAlignment: :center.uialignment,
    constraints: [
      constrain_width(200),
      constrain(:center_x).equals(:superview, :center_x),
      constrain_below(:cordial_invite_label, 10),
    ]

  style :commissioner_title,
    text: 'Commissioner',
    background: :clear.uicolor,
    font: 'HelveticaNeue'.uifont(14),
    textAlignment: :center.uialignment,
    constraints: [
      constrain_width(200),
      constrain(:center_x).equals(:superview, :center_x),
      constrain_below(:league_name, 5),
    ]

  style :commissioner_name,
    background: :clear.uicolor,
    font: 'Satisfy'.uifont(30),
    textAlignment: :center.uialignment,
    constraints: [
      constrain_width(200),
      constrain(:center_x).equals(:superview, :center_x),
      constrain_below(:commissioner_title, 5),
    ]

  style :rules_label,
    background: :clear.uicolor,
    font: 'HelveticaNeue'.uifont(24),
    textAlignment: :center.uialignment

  style :players_per_team, extends: :rules_label,
    constraints: [
      constrain_width(200),
      constrain_below(:commissioner_name, 10),
      constrain(:center_x).equals(:superview, :center_x),
    ]

  style :balls_back, extends: :rules_label,
    constraints: [
      constrain_width(200),
      constrain_below(:players_per_team, 5),
      constrain(:center_x).equals(:superview, :center_x),
    ]

  style :rerack_cups, extends: :rules_label,
    constraints: [
      constrain_width(200),
      constrain_below(:balls_back, 5),
      constrain(:center_x).equals(:superview, :center_x),
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
