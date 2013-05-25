class Player
  attr_accessor :name, :email, :password, :api_key, :registered_at

  def sign_up(info)
    @name = info[:name]
  end
end
