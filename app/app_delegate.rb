# style constants
FieldHeight = 50
ButtonHeight = 60
ControlWidth = 240
KeyboardHeight = Device.iphone? ? 216 : 264

# controller sidekicks
DoneWithKeyboard = UIControlEventEditingDidEndOnExit
class App
  def has_internet?
    Reachability.reachabilityWithHostname('google.com').isReachable == 1
  end
end

BaseURL = 'http://localhost'

# App's entry point
class AppDelegate < ProMotion::Delegate
  def on_load(app, options)
    open LoginScreen
  end
end

# style default UI components
Teacup::Appearance.new do
  style UINavigationBar,
    tintColor: 0x0088cc.uicolor

  style UIBarButtonItem, when_contained_in: UINavigationBar,
    tintColor: 0x0088cc.uicolor
end
