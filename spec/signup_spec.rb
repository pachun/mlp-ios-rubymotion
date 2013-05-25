describe 'The Signup Screen' do
  tests SignupScreen

  # forwards the keybaord from the email field to the password field
  # forwards the keybaord from the password field to the confirm password field
  # drops the keyboard after the confirmed password is entered
  # drops the keyboard when the signup button is tapped and the email field is selected
  # drops the keyboard when the signup button is tapped and the password field is selected
  # drops the keyboard when the signup button is tapped and the confirm password field is selected
  # drops the keyboard when the background is tapped and the email field is selected
  # drops the keyboard when the background is tapped and the password field is selected
  # drops the keyboard when the background is tapped and the confirm password field is selected

  it 'forwards the keybaord from the email field to the password field' do
    tap('Email')
    tap('Signup Screen', :at => CGPointMake(310, 558))
    controller.password_field.isFirstResponder.should == true
  end

  it 'forwards the keybaord from the password field to the confirm password field' do
    tap('Password')
    tap('Signup Screen', :at => CGPointMake(310, 558))
    controller.confirm_password_field.isFirstResponder.should == true
  end

  it 'drops the keyboard after the confirmed password is entered' do
    tap('Confirm Password')
    tap('Signup Screen', :at => CGPointMake(310, 558))
    controller.confirm_password_field.isFirstResponder.should == false
  end

  it 'drops the keyboard when the signup button is tapped and the email field is selected' do
    tap('Email')
    tap('Sign Up')
    controller.email_field.isFirstResponder.should == false
  end

  it 'drops the keyboard when the signup button is tapped and the password field is selected' do
    tap('Password')
    tap('Sign Up')
    controller.password_field.isFirstResponder.should == false
  end

  it 'drops the keyboard when the signup button is tapped and the confirm password field is selected' do
    tap('Confirm Password')
    tap('Sign Up')
    controller.confirm_password_field.isFirstResponder.should == false
  end

  it 'drops the keyboard when the background is tapped and the email field is selected' do
    tap('Email')
    tap('Signup Screen', :at => CGPointMake(25, 25))
    controller.email_field.isFirstResponder.should == false
  end

  it 'drops the keyboard when the background is tapped and the password field is selected' do
    tap('Password')
    tap('Signup Screen', :at => CGPointMake(25, 25))
    controller.password_field.isFirstResponder.should == false
  end

  it 'drops the keyboard when the background is tapped and the confirm password field is selected' do
    tap('Confirm Password')
    tap('Signup Screen', :at => CGPointMake(25, 25))
    controller.confirm_password_field.isFirstResponder.should == false
  end
end
