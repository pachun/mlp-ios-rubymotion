class SignupScreen < ProMotion::Screen
  stylesheet :signup_sheet

  layout :root do
    subview(UILabel, :hello)
    subview(UIImageView, :ten_cup_rack)
    subview(UIView, :signup_box)
    subview(UIView, :separator1)
    subview(UIView, :separator2)
    @email_field = subview(UITextField, :email_field)
    @password_field = subview(UITextField, :password_field)
    @confirm_password_field = subview(UITextField, :confirm_password_field)
    @signup_button = subview(UIButton.custom, :signup_button)
    @login_button = subview(UIButton.custom, :login_button)
  end

  def layoutDidLoad
    @password_field.secureTextEntry = true
    @confirm_password_field.secureTextEntry = true
    @signup_button.setTitle('Sign Up', forState:UIControlStateNormal)
    @signup_button.setTitleColor(:white.uicolor, forState:UIControlStateNormal)
    @login_button.setTitle('Back to Login', forState:UIControlStateNormal)
    @login_button.setTitleColor(:white.uicolor, forState:UIControlStateNormal)
    did_load
  end
end
