Teacup::Stylesheet.new(:login_sheet) do
  style :root,
    background: 0xf7f7f7,
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

  style :login_box,
    background: :white.uicolor,
    layer: {
      cornerRadius: 2,
      borderWidth: 1,
      borderColor: 0xd6d6d6.uicolor.CGColor,
    },
    constraints: [
      constrain_width(ControlWidth),
      constrain_height(FieldHeight * 2),
      constrain_above(:login_button, 15),
      constrain(:center_x).equals(:superview, :center_x),
    ]

  style :separator,
    background: 0xd6d6d6,
    constraints: [
      constrain_height(1),
      constrain(:width).equals(:login_box, :width),
      constrain(:center_x).equals(:login_box, :center_x),
      constrain(:center_y).equals(:login_box, :center_y),
    ]

  style :login_field,
      backgroundColor: :clear.uicolor,
      font: 'HelveticaNeue'.uifont(20),
      borderStyle: UITextBorderStyleNone,
      contentVerticalAlignment: UIControlContentVerticalAlignmentCenter

  style :email_field, extends: :login_field,
    placeholder: 'Email',
    returnKeyType: UIReturnKeyNext,
    keyboardType: UIKeyboardTypeEmailAddress,
    autocorrectionType: UITextAutocorrectionTypeNo,
    autocapitalizationType: UITextAutocapitalizationTypeNone,
    constraints: [
      constrain_height(FieldHeight),
      constrain(:top).equals(:login_box, :top),
      constrain(:center_x).equals(:login_box, :center_x),
      constrain(:width).equals(:login_box, :width).minus(20),
    ]

  style :password_field, extends: :login_field,
      placeholder: 'Password',
      returnKeyType: UIReturnKeyGo,
      constraints: [
        constrain_height(50),
        constrain(:bottom).equals(:login_box, :bottom),
        constrain(:center_x).equals(:login_box, :center_x),
        constrain(:width).equals(:login_box, :width).minus(20),
      ]

  style :button,
    font: 'HelveticaNeue-Bold'.uifont(18),
    layer: { cornerRadius: 2 }

  style :login_button, extends: :button,
    background: 0xe5603c,
    constraints: [
      constrain_width(ControlWidth),
      constrain_height(ButtonHeight),
      constrain(:center_x).equals(:superview, :center_x),
      constrain(:bottom).equals(:superview, :bottom).minus(KeyboardHeight + 30),
    ]

  style :signup_button, extends: :button,
    background: 0x12619A,
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
