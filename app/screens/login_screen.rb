class LoginScreen < ProMotion::Screen

  # fields
  attr_accessor :email_field, :password_field
  # buttons
  attr_accessor :login_button, :signup_button

  # wire up tap events & keyboard forwarding
  def did_load
    @email_field.when(DoneWithKeyboard) { @password_field.becomeFirstResponder }
    @password_field.when(DoneWithKeyboard) { drop_keyboard }
    @login_button.when_tapped { drop_keyboard }
    @signup_button.when_tapped { open SignupScreen.new, modal:true }
    view.when_tapped { drop_keyboard }
  end

  def drop_keyboard
    @email_field.resignFirstResponder
    @password_field.resignFirstResponder
  end
end
