Teacup::Stylesheet.new(:signup_sheet) do
  import :mlp

  style :root,
    background: BackgroundColor,
    accessibilityLabel: 'Signup Screen'

  style :signup_box, extends: :field_box,
    constraints: [
      constrain_width(ControlWidth),
      constrain_height(FieldHeight * 4),
      constrain_above(:signup_button, 15),
      constrain(:center_x).equals(:superview, :center_x),
    ]

  style :separator1, extends: :field_separator,
    constraints: [
      constrain_height(1),
      constrain(:width).equals(:signup_box, :width),
      constrain(:top).equals(:signup_box, :top).plus(50),
      constrain(:center_x).equals(:signup_box, :center_x),
    ]

  style :separator2, extends: :field_separator,
    constraints: [
      constrain_height(1),
      constrain(:width).equals(:signup_box, :width),
      constrain(:top).equals(:signup_box, :top).plus(100),
      constrain(:center_x).equals(:signup_box, :center_x),
    ]

  style :separator3, extends: :field_separator,
    constraints: [
      constrain_height(1),
      constrain(:width).equals(:signup_box, :width),
      constrain(:bottom).equals(:signup_box, :bottom).minus(50),
      constrain(:center_x).equals(:signup_box, :center_x),
    ]

  style :name_field, extends: :field_name,
    placeholder: 'Full Name',
    constraints: [
      constrain_height(FieldHeight),
      constrain(:top).equals(:signup_box, :top),
      constrain(:center_x).equals(:signup_box, :center_x),
      constrain(:width).equals(:signup_box, :width).minus(20),
    ]

  style :email_field, extends: :field_email,
    placeholder: 'Email',
    constraints: [
      constrain_below(:name_field),
      constrain_height(FieldHeight),
      constrain(:center_x).equals(:signup_box, :center_x),
      constrain(:width).equals(:signup_box, :width).minus(20),
    ]

  style :password_field, extends: :field,
    placeholder: 'Password',
    constraints: [
      constrain_height(50),
      constrain_below(:email_field),
      constrain(:center_x).equals(:signup_box, :center_x),
      constrain(:width).equals(:signup_box, :width).minus(20),
    ]

  style :confirm_password_field, extends: :field,
    placeholder: 'Confirm Password',
    returnKeyType: UIReturnKeyGo,
    constraints: [
      constrain_height(50),
      constrain(:bottom).equals(:signup_box, :bottom),
      constrain(:center_x).equals(:signup_box, :center_x),
      constrain(:width).equals(:signup_box, :width).minus(20),
    ]

  style :signup_button, extends: :red_button,
    constraints: [
      constrain_width(ControlWidth),
      constrain_height(ButtonHeight),
      constrain(:center_x).equals(:superview, :center_x),
      constrain_above(:login_button, 120),
    ]

  style :login_button, extends: :blue_button,
    constraints: [
      constrain_width(ControlWidth),
      constrain_height(ButtonHeight),
      constrain(:center_x).equals(:superview, :center_x),
      constrain(:bottom).equals(:superview, :bottom).minus(20),
    ]

  style :ten_cup_rack,
    image: '10rack.png',
    constraints: [
      constrain(:top).equals(:superview, :top).minus(11).plus(20),
      constrain(:center_x).equals(:superview, :right),
    ]

  style :hello,
    text: 'Hello',
    font: 'Satisfy'.uifont(34),
    background: :clear.uicolor,
    constraints: [
      constrain_above(:signup_box, 2),
      constrain(:left).equals(:signup_box, :left),
    ]
end
