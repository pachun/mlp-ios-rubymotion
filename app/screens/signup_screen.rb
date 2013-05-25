class SignupScreen < ProMotion::Screen

  # fields
  attr_accessor :name_field, :email_field, :password_field, :confirm_password_field
  # buttons
  attr_accessor :signup_button, :login_button
  # persistence
  attr_accessor :player

  # setup transition style when the view is constructed
  def on_load
    self.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal
  end

  # wire up tap events & keyboard forwarding
  def did_load
    @name_field.when(DoneWithKeyboard) { @email_field.becomeFirstResponder }
    @email_field.when(DoneWithKeyboard) { @password_field.becomeFirstResponder }
    @password_field.when(DoneWithKeyboard) { @confirm_password_field.becomeFirstResponder }
    @confirm_password_field.when(DoneWithKeyboard) { drop_keyboard }
    @login_button.when_tapped { dismissViewControllerAnimated(true, completion: nil) }
    view.when_tapped { drop_keyboard }
    enable_signup_button
  end

  private

  def drop_keyboard
    @name_field.resignFirstResponder
    @email_field.resignFirstResponder
    @password_field.resignFirstResponder
    @confirm_password_field.resignFirstResponder
  end

  def disable_signup_button
    @signup_button.when_tapped {}
  end

  def enable_signup_button
    @signup_button.when_tapped { signup }
  end

  def signup
    drop_keyboard
    disable_signup_button

    @player = Player.new
    @player.name = @name_field.text
    @player.email = @email_field.text
    @player.password = @password_field.text
    @player.confirmed_password = @confirm_password_field.text
    @player.signup do
      if @player.saved
        SVProgressHUD.showSuccessWithStatus('Player Created!')
        # dismissViewControllerAnimated(true, completion:nil)
      else
        SVProgressHUD.showErrorWithStatus(@player.error)
        enable_signup_button
      end
    end
  end
end
