describe 'The Login Screen' do
  tests LoginScreen

  # it forwards the keyboard from the email field to the password field
  # it drops the keyboard after the password is typed
  # it drops the keyboard when the login button is tapped and the email field is selected
  # it drops the keyboard when the login button is tapped and the password field is selected
  # it drops the keyboard when the background is tapped and the email field is selected
  # it drops the keyboard when the background is tapped and the password field is selected
  # it transitions to the signup view

  it 'forwards the keyboard from the email field to the password field' do
    tap('Email')
    tap('Login Screen', :at => CGPointMake(310, 558))
    controller.password_field.isFirstResponder.should == true
  end

  it 'drops the keyboard after the password is typed' do
    tap('Password')
    tap('Login Screen', :at => CGPointMake(310, 558))
    controller.password_field.isFirstResponder.should == false
  end

  it 'drops the keyboard when the login button is tapped and the email field is selected' do
    tap('Email')
    tap('Log In')
    controller.email_field.isFirstResponder.should == false
  end

  it 'drops the keyboard when the login button is tapped and the password field is selected' do
    tap('Password')
    tap('Log In')
    controller.password_field.isFirstResponder.should == false
  end

  it 'drops the keyboard when the background is tapped and the email field is selected' do
    tap('Email')
    tap('Login Screen', :at => CGPointMake(25, 25))
    controller.email_field.isFirstResponder.should == false
  end

  it 'drops the keyboard when the background is tapped and the password field is selected' do
    tap('Password')
    tap('Login Screen', :at => CGPointMake(25, 25))
    controller.password_field.isFirstResponder.should == false
  end

  describe 'Shows the signup screen smoothly' do
    before do
      tap('Sign Up')
    end

    it 'shows the signup screen with a flip when signup is tapped' do
      signup_screen = controller.presentedViewController
      signup_screen.class.should == SignupScreen
      signup_screen.modalTransitionStyle.should == UIModalTransitionStyleFlipHorizontal
    end

    it 'Goes back to the login screen when \'Back to Login\' is tapped' do
      tap('Back to Login')
      proper_wait 0.5
      controller.presentedViewController.should == nil
    end
  end
end
