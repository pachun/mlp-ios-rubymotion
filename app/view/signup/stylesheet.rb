Teacup::Stylesheet.new(:signup_sheet) do
  style :root,
    background: 0xf7f7f7,
    accessibilityLabel: 'Signup Screen'

  style :signup_box,
    background: :white.uicolor,
    layer: {
      cornerRadius: 2,
      borderWidth: 1,
      borderColor: 0xd6d6d6.uicolor.CGColor,
    },
    constraints: [
      constrain_width(ControlWidth),
      constrain_height(FieldHeight * 4),
      constrain_above(:signup_button, 15),
      constrain(:center_x).equals(:superview, :center_x),
    ]

  style :separator1,
    background: 0xd6d6d6,
    constraints: [
      constrain_height(1),
      constrain(:width).equals(:signup_box, :width),
      constrain(:top).equals(:signup_box, :top).plus(50),
      constrain(:center_x).equals(:signup_box, :center_x),
    ]

  style :separator2,
    background: 0xd6d6d6,
    constraints: [
      constrain_height(1),
      constrain(:width).equals(:signup_box, :width),
      constrain(:top).equals(:signup_box, :top).plus(100),
      constrain(:center_x).equals(:signup_box, :center_x),
    ]

  style :separator3,
    background: 0xd6d6d6,
    constraints: [
      constrain_height(1),
      constrain(:width).equals(:signup_box, :width),
      constrain(:bottom).equals(:signup_box, :bottom).minus(50),
      constrain(:center_x).equals(:signup_box, :center_x),
    ]

  style :signup_field,
      backgroundColor: :clear.uicolor,
      font: 'HelveticaNeue'.uifont(20),
      borderStyle: UITextBorderStyleNone,
      contentVerticalAlignment: UIControlContentVerticalAlignmentCenter

  style :name_field, extends: :signup_field,
    placeholder: 'Full Name',
    returnKeyType: UIReturnKeyNext,
    autocorrectionType: UITextAutocorrectionTypeNo,
    autocapitalizationType: UITextAutocapitalizationTypeWords,
    constraints: [
      constrain_height(FieldHeight),
      constrain(:top).equals(:signup_box, :top),
      constrain(:center_x).equals(:signup_box, :center_x),
      constrain(:width).equals(:signup_box, :width).minus(20),
    ]

  style :email_field, extends: :signup_field,
    placeholder: 'Email',
    returnKeyType: UIReturnKeyNext,
    keyboardType: UIKeyboardTypeEmailAddress,
    autocorrectionType: UITextAutocorrectionTypeNo,
    autocapitalizationType: UITextAutocapitalizationTypeNone,
    constraints: [
      constrain_below(:name_field),
      constrain_height(FieldHeight),
      constrain(:center_x).equals(:signup_box, :center_x),
      constrain(:width).equals(:signup_box, :width).minus(20),
    ]

  style :password_field, extends: :signup_field,
      placeholder: 'Password',
      returnKeyType: UIReturnKeyNext,
      constraints: [
        constrain_height(50),
        constrain_below(:email_field),
        constrain(:center_x).equals(:signup_box, :center_x),
        constrain(:width).equals(:signup_box, :width).minus(20),
      ]

  style :confirm_password_field, extends: :signup_field,
      placeholder: 'Confirm Password',
      returnKeyType: UIReturnKeyGo,
      constraints: [
        constrain_height(50),
        constrain(:bottom).equals(:signup_box, :bottom),
        constrain(:center_x).equals(:signup_box, :center_x),
        constrain(:width).equals(:signup_box, :width).minus(20),
      ]

  style :button,
    font: 'HelveticaNeue-Bold'.uifont(18),
    layer: { cornerRadius: 2 }

  style :signup_button, extends: :button,
    background: 0xe5603c,
    constraints: [
      constrain_width(ControlWidth),
      constrain_height(ButtonHeight),
      constrain(:center_x).equals(:superview, :center_x),
      constrain_above(:login_button, 120),
    ]

  style :login_button, extends: :button,
    background: 0x12619A,
    constraints: [
      constrain_width(ControlWidth),
      constrain_height(ButtonHeight),
      constrain(:center_x).equals(:superview, :center_x),
      constrain(:bottom).equals(:superview, :bottom).minus(20),
    ]

  style :ten_cup_rack,
    image: '10rack.png',
    constraints: [
      constrain(:top).equals(:superview, :top).minus(11),
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
