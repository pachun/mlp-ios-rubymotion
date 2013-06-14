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
class AppDelegate < ProMotion::Delegate
  def on_load(app, options)
    customize_appearance
    open LoginScreen
  end
end

def customize_appearance
  customize_nav_bar
  customize_tab_bar
  customize_nav_bar_buttons
end

def customize_nav_bar
  UINavigationBar.appearance.setBackgroundImage(UIImage.alloc.init, forBarMetrics:UIBarMetricsDefault)
  UINavigationBar.appearance.setBackgroundColor(BlueColor)
end

def customize_tab_bar
  UITabBar.appearance.setBackgroundImage('tabbar.png'.uiimage)
end

def customize_nav_bar_buttons
  bar_button = UIImage.alloc.init.resizableImageWithCapInsets(UIEdgeInsetsMake(0, 5, 0, 5))
  back_button = 'back.png'.uiimage.resizableImageWithCapInsets(UIEdgeInsetsMake(0, 14, 0, 5))
  UIBarButtonItem.appearance.setBackgroundImage(bar_button, forState:UIControlStateNormal, barMetrics:UIBarMetricsDefault)
  UIBarButtonItem.appearance.setBackButtonBackgroundImage(back_button, forState:UIControlStateNormal, barMetrics:UIBarMetricsDefault)
end
