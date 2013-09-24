BackgroundColor = 0xf7f7f7.uicolor
FieldColor = :white.uicolor
TrimColor = 0xd6d6d6.uicolor
BlueColor = 0x12619a.uicolor
RedColor = 0xe5603c.uicolor
NavbarColor = 0x0088cc.uicolor
NavBarHeight = 44
StatusBarHeight = 20
TabBarHeight = 49
NavTopHeight = StatusBarHeight + NavBarHeight

# style default UI components
Teacup::Appearance.new do
  style UINavigationBar,
    tintColor: NavbarColor

  style UIBarButtonItem, when_contained_in: UINavigationBar,
    tintColor: NavbarColor
end

# style custom components
Teacup::Stylesheet.new(:mlp) do
  style :field_box,
    background: FieldColor,
    layer: {
      cornerRadius: 2,
      borderWidth: 1,
      borderColor: TrimColor.CGColor,
    }

  style :field_separator,
    background: TrimColor

  style :field,
    returnKeyType: UIReturnKeyNext,
    backgroundColor: :clear.uicolor,
    font: 'HelveticaNeue'.uifont(20),
    borderStyle: UITextBorderStyleNone,
    contentVerticalAlignment: UIControlContentVerticalAlignmentCenter

  style :field_email, extends: :field,
    placeholder: 'Email',
    keyboardType: UIKeyboardTypeEmailAddress,
    autocorrectionType: UITextAutocorrectionTypeNo,
    autocapitalizationType: UITextAutocapitalizationTypeNone

  style :field_name, extends: :field,
    returnKeyType: UIReturnKeyNext,
    autocorrectionType: UITextAutocorrectionTypeNo,
    autocapitalizationType: UITextAutocapitalizationTypeWords

  style :button,
    font: 'HelveticaNeue-Bold'.uifont(18),
    layer: { cornerRadius: 2 }

  style :blue_button, extends: :button,
    background: BlueColor

  style :red_button, extends: :button,
    background: RedColor
end
