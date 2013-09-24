class LoginScreen < ProMotion::Screen
  attr_accessor :player

  def did_load
    @email_field.text = 'hello@nickpachulski.com'
    @password_field.text = 'password'
    @email_field.when(DoneWithKeyboard) { @password_field.becomeFirstResponder }
    @password_field.when(DoneWithKeyboard) { drop_keyboard }
    @signup_button.when_tapped { flip_to_signup_screen }
    view.when_tapped { drop_keyboard }
    enable_login_button
  end

  def on_return(args = {})
    @email_field.text = args[:email]
    @password_field.text = args[:password]
  end

  private

  def drop_keyboard
    @email_field.resignFirstResponder
    @password_field.resignFirstResponder
  end

  def flip_to_signup_screen
    signup_screen = SignupScreen.new
    signup_screen.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal
    open signup_screen, modal: true
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
        open LeaguesScreen.new(nav_bar: true, signedin_player: @player), modal: true
      else
        SVProgressHUD.showErrorWithStatus(@player.error)
      end
      enable_login_button
    end
  end
end
