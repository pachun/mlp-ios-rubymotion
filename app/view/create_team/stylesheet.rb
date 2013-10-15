Teacup::Stylesheet.new(:create_team_sheet) do
  import :mlp

  style :root,
    background: BackgroundColor

  style :name_box, extends: :field_box,
    constraints: [
      constrain_height(FieldHeight),
      constrain_width(ControlWidth),
      constrain(:top).equals(:superview, :top).plus(20).plus(NavTopHeight),
      constrain(:center_x).equals(:superview, :center_x),
    ]

  style :name_field, extends: :field,
    placeholder: 'Team Name',
    returnKeyType: UIReturnKeyDone,
    constraints: [
      constrain_height(FieldHeight),
      constrain(:center_y).equals(:superview, :center_y),
      constrain(:center_x).equals(:superview, :center_x),
      constrain(:width).equals(:superview, :width).minus(20),
    ]

  style :label,
    font: :bold.uifont(18),
    background: :clear.uicolor,
    textAlignment: :center.uialignment

  style :teammate_icon,
    layer: {
      masksToBounds: true,
      cornerRadius: 30,
      borderWidth: 1,
      borderColor: TrimColor,
    }

  style :creater_name, extends: :label,
    constraints: [
      constrain_width(ControlWidth),
      constrain_below(:name_field, 10),
      constrain(:center_x).equals(:superview, :center_x),
    ]

  style :creater_icon, extends: :teammate_icon,
    constraints: [
      constrain_width(60),
      constrain_height(60),
      constrain_below(:creater_name, 5),
      constrain(:center_x).equals(:superview, :center_x),
    ]

  style :teammate1_name, extends: :label,
    constraints: [
      constrain_width(ControlWidth),
      constrain_below(:creater_icon, 5),
      constrain(:center_x).equals(:superview, :center_x),
    ]

  style :teammate1_icon, extends: :teammate_icon,
    constraints: [
      constrain_width(60),
      constrain_height(60),
      constrain_below(:teammate1_name, 5),
      constrain(:center_x).equals(:superview, :center_x),
    ]

  style :teammate2_name, extends: :label,
    constraints: [
      constrain_width(ControlWidth),
      constrain_below(:teammate1_icon, 5),
      constrain(:center_x).equals(:superview, :center_x),
    ]

  style :teammate2_icon, extends: :teammate_icon,
    constraints: [
      constrain_width(60),
      constrain_height(60),
      constrain_below(:teammate2_name, 5),
      constrain(:center_x).equals(:superview, :center_x),
    ]

  style :invite_button, extends: :red_button,
    constraints: [
      constrain_width(ControlWidth),
      constrain_height(ButtonHeight),
      constrain(:center_x).equals(:superview, :center_x),
      constrain(:bottom).equals(:superview, :bottom).minus(20).minus(TabBarHeight),
    ]
end
