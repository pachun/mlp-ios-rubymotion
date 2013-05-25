class SignupScreen < ProMotion::Screen

  # fields
  attr_accessor :email_field, :password_field, :confirm_password_field
  # buttons
  attr_accessor :signup_button, :login_button

  # setup transition style when the view is constructed
  def on_load
    self.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal
  end

  # wire up tap events & keyboard forwarding
  def did_load
    @email_field.when(DoneWithKeyboard) { @password_field.becomeFirstResponder }
    @password_field.when(DoneWithKeyboard) { @confirm_password_field.becomeFirstResponder }
    @confirm_password_field.when(DoneWithKeyboard) { drop_keyboard }
    @signup_button.when_tapped { drop_keyboard }
    @login_button.when_tapped { dismissViewControllerAnimated(true, completion: nil) }
    view.when_tapped { drop_keyboard }
  end

  def drop_keyboard
    @email_field.resignFirstResponder
    @password_field.resignFirstResponder
    @confirm_password_field.resignFirstResponder
  end
end
