class LoginScreen < ProMotion::Screen
  attr_accessor :email_field, :password_field, :login_button, :signup_button, :forgot_password_button
  stylesheet :login_sheet

  layout :root do
    subview(UIImageView, :pong_man)
    subview(UIView, :login_box)
    subview(UIView, :separator)
    @email_field = subview(UITextField, :email_field)
    @password_field = subview(UITextField, :password_field)
    @login_button = subview(UIButton.custom, :login_button)
    @forgot_password_button = subview(UIButton.custom, :forgot_password_button)
    @signup_button = subview(UIButton.custom, :signup_button)
  end

  def layoutDidLoad
    @password_field.secureTextEntry = true
    @login_button.setTitle('Log In', forState:UIControlStateNormal)
    @login_button.setTitleColor(:white.uicolor, forState:UIControlStateNormal)
    @forgot_password_button.setTitle('Forgot Password', forState:UIControlStateNormal)
    @forgot_password_button.setTitleColor(:white.uicolor, forState:UIControlStateNormal)
    @signup_button.setTitle('Sign Up', forState:UIControlStateNormal)
    @signup_button.setTitleColor(:white.uicolor, forState:UIControlStateNormal)
    did_load
  end
end
