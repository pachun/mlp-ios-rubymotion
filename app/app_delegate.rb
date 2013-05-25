class AppDelegate < ProMotion::Delegate
  def on_load(app, options)
    open LoginScreen.new
  end
end

# controller sidekicks
DoneWithKeyboard = UIControlEventEditingDidEndOnExit

# style constants
FieldHeight = 50
ButtonHeight = 60
ControlWidth = 240
KeyboardHeight = Device.iphone? ? 216 : 264
