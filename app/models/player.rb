class Player
  attr_accessor :id, :name, :email, :password, :api_key, :registered_at,
    :confirmed_password, :error, :saved

  # UI entry points
  def signup(&block)
    @saved = false
    if valid_signup_credentials?
      send_signup_request(&block)
    else
      block.call
    end
  end

  def login(&block)
    if valid_login_credentials?
      send_login_request(&block)
    else
      block.call
    end
  end

  # shortcuts
  def logged_in?
    @api_key.class == String && @api_key.length == 32
  end

  private

  # requests
  def send_login_request(&block)
    data = {:player => {:email => @email,
                        :password => @password,
    }}
    BW::HTTP.post(BaseURL + '/login', {:payload => data}) do |response|
      if response.ok?
        json = BW::JSON.parse(response.body.to_str)
        @id = json['id']
        @name = json['name']
        @api_key = json['api_key']
      else
        @error = 'Bad credentials'
      end
      block.call
    end
  end

  def send_signup_request(&block)
    data = {:player => {:full_name => @name,
                        :email => @email,
                        :password => @password,
    }}
    BW::HTTP.post(BaseURL + '/player', {:payload => data}) do |response|
      if response.ok?
        @saved = true
      else
        @error = 'Email in use'
        @saved = false
      end
      block.call
    end
  end

  # validations
  def valid_login_credentials?
    if valid_email && valid_password
      true
    else
      false
    end
  end

  def valid_signup_credentials?
    if valid_name && valid_email && valid_password && password_confirmed
      true
    else
      false
    end
  end

  def valid_name
    if @name.class == String && @name.length >= 5 && @name.length <= 50
      true
    else
      @error = 'Names are [5,50] long'
      false
    end
  end

  def valid_email
    if @email.class == String && ((@email =~ /\A.+@.+\.(com|org|net|ca|us|co\.uk)\z/) == 0) && @email.length >= 6 && @email.length <= 75
      true
    else
      @error = 'Valid emails are [6,75] long'
      false
    end
  end

  def valid_password
    if @password.class == String && @password.length >= 4
      true
    else
      @error = 'Passwords are at least 4 long'
      false
    end
  end

  def password_confirmed
    if @password == @confirmed_password
      true
    else
      @error = 'Mismatched passwords'
      false
    end
  end
end
