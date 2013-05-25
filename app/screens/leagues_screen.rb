class LeaguesScreen < ProMotion::SectionedTableScreen
  attr_accessor :player

  title 'Welcome'

  def on_load
    set_nav_bar_left_button('Sign Out', action: :logout)
    set_nav_bar_right_button(nil, action: :create_league, system_icon: UIBarButtonSystemItemAdd)
  end

  def table_data
    [
      {title: 'Leagues', cells: []},
      {title: 'Invites', cells: []},
    ]
  end

  private

  def logout
  end

  def create_league
  end
end
