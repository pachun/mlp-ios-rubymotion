class LoginScreen < ProMotion::Screen

  # fields
  attr_accessor :email_field, :password_field
  # buttons
  attr_accessor :login_button, :signup_button

  attr_accessor :player

  # wire up tap events & keyboard forwarding
  def did_load
    @email_field.when(DoneWithKeyboard) { @password_field.becomeFirstResponder }
    @password_field.when(DoneWithKeyboard) { drop_keyboard }
    @signup_button.when_tapped { flip_to_signup_screen }
    view.when_tapped { drop_keyboard }
    enable_login_button
  end

  private

  def drop_keyboard
    @email_field.resignFirstResponder
    @password_field.resignFirstResponder
  end

  def flip_to_signup_screen
    open SignupScreen.new(login_screen: self), modal: true
  end

  def enable_login_button
    @login_button.when_tapped do
      disable_login_button
      drop_keyboard
      login
    end
  end

  def disable_login_button
    @login_button.when_tapped {}
  end

  def login
    @player = Player.new
    @player.email = @email_field.text
    @player.password = @password_field.text
    @player.login do
      if @player.logged_in?
        open LeaguesScreen.new(nav_bar: true, player: @player), modal: true
      else
        SVProgressHUD.showErrorWithStatus(@player.error)
        enable_login_button
      end
    end
  end
end
