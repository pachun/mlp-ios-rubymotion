Teacup::Stylesheet.new(:login_sheet) do
  import :mlp

  style :root,
    background: BackgroundColor,
    accessibilityLabel: 'Login Screen'

  style :pong_man,
    image: 'large_pong_man.png',
    layer: {
      cornerRadius: 6,
      masksToBounds: true,
    },
    constraints: [
      constrain_width(60),
      constrain_height(60),
      constrain_above(:login_box, 10),
      constrain(:left).equals(:login_box, :left),
    ]

  style :login_box, extends: :field_box,
    constraints: [
      constrain_width(ControlWidth),
      constrain_height(FieldHeight * 2),
      constrain_above(:login_button, 15),
      constrain(:center_x).equals(:superview, :center_x),
    ]

  style :separator, extends: :field_separator,
    constraints: [
      constrain_height(1),
      constrain(:width).equals(:login_box, :width),
      constrain(:center_x).equals(:login_box, :center_x),
      constrain(:center_y).equals(:login_box, :center_y),
    ]

  style :email_field, extends: :field_email,
    placeholder: 'Email',
    constraints: [
      constrain_height(FieldHeight),
      constrain(:top).equals(:login_box, :top),
      constrain(:center_x).equals(:login_box, :center_x),
      constrain(:width).equals(:login_box, :width).minus(20),
    ]

  style :password_field, extends: :field,
      placeholder: 'Password',
      returnKeyType: UIReturnKeyGo,
      constraints: [
        constrain_height(50),
        constrain(:bottom).equals(:login_box, :bottom),
        constrain(:center_x).equals(:login_box, :center_x),
        constrain(:width).equals(:login_box, :width).minus(20),
      ]

  style :login_button, extends: :red_button,
    constraints: [
      constrain_width(ControlWidth),
      constrain_height(ButtonHeight),
      constrain(:center_x).equals(:superview, :center_x),
      constrain(:bottom).equals(:superview, :bottom).minus(KeyboardHeight + 30),
    ]

  style :signup_button, extends: :blue_button,
    constraints: [
      constrain_width(ControlWidth),
      constrain_height(ButtonHeight),
      constrain(:center_x).equals(:superview, :center_x),
      constrain(:bottom).equals(:superview, :bottom).minus(20),
    ]

  style :or_label,
    text: 'Or you can',
    background: :clear.uicolor,
    font: 'Satisfy'.uifont(30),
    constraints: [
      constrain(:center_x).equals(:superview, :center_x),
      constrain_above(:signup_button, 10),
    ]
end
