class LogoutScreen < ProMotion::Screen
  def will_appear
    navigationItem.title = 'Logout'
    view.backgroundColor = BackgroundColor
  end
end
