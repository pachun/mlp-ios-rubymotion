class LeaguesScreen < ProMotion::SectionedTableScreen
  attr_accessor :player, :table_data, :selected_league

  title 'Leagues'

  def on_load
    setup_navbar
    @table_data = [{cells: []}]
  end

  def will_appear
    populate_leagues
    populate_invites
  end

  def tapped(touched)
    if touched[:type] == :league
      @selected_league = touched[:league]
      open_league_overview
    elsif touched[:type] == :invite
      open LeaguePlayerInviteScreen.new(player: @player, league: touched[:league])
    end
  end

  private

  def setup_navbar
    set_nav_bar_left_button('Sign Out', action: :logout)
    set_nav_bar_right_button(nil, action: :create_league, system_icon: UIBarButtonSystemItemAdd)
  end

  def logout
    dismiss_modal
  end

  def create_league
    create_league_screen = CreateLeagueScreen.new
    create_league_screen.player = @player
    create_league_screen.leagues_screen = self
    open create_league_screen
  end

  def open_league_overview
    tab_bar = UITabBarController.new
    tab_bar.viewControllers = [players_tab, teams_tab, games_tab, invites_tab, more_tab]
    present_modal(tab_bar)
  end

  def players_tab
    screen = PlayersScreen.new
    screen.league = @selected_league
    screen.player = @player
    tab = UITabBarItem.alloc.initWithTitle('Players', image:'players.png'.uiimage, tag:0)
    screen.setTabBarItem(tab)
    nav = UINavigationController.new
    nav << screen
    nav
  end

  def teams_tab
    screen = TeamsScreen.new
    screen.league = @selected_league
    screen.player = @player
    tab = UITabBarItem.alloc.initWithTitle('Teams', image:'teams.png'.uiimage, tag:0)
    screen.setTabBarItem(tab)
    nav = UINavigationController.new
    nav << screen
    nav
  end

  def games_tab
    screen = GamesScreen.new
    screen.league = @league
    tab = UITabBarItem.alloc.initWithTitle('Games', image:'games.png'.uiimage, tag:0)
    screen.setTabBarItem(tab)
    nav = UINavigationController.new
    nav << screen
    nav
  end

  def invites_tab
    screen = InvitesScreen.new
    screen.league = @league
    tab = UITabBarItem.alloc.initWithTitle('Invites', image:'invites.png'.uiimage, tag:0)
    screen.setTabBarItem(tab)
    nav = UINavigationController.new
    nav << screen
    nav
  end

  def more_tab
    screen = MoreScreen.new
    screen.league = @league
    tab = UITabBarItem.alloc.initWithTitle('More', image:'more.png'.uiimage, tag:0)
    screen.setTabBarItem(tab)
    nav = UINavigationController.new
    nav << screen
    nav
  end

  def populate_leagues
    @player.populate_leagues do
      cells = @player.leagues.map { |league| cell_for(:league, league) }
      @table_data.first[:cells] = cells
      update_table_data
    end
  end

  def populate_invites
    @player.populate_invited_leagues do
      if @player.invited_leagues.count > 0
        cells = @player.invited_leagues.map { |league| cell_for(:invite, league) }
        @table_data[1] = {title: 'Invites', cells: cells}
      else
        @table_data.delete_at(1) if !@table_data[1].nil?
      end
      update_table_data
    end
  end

  def cell_for(type, league)
    {
      :title => league.name,
      :subtitle => league.commissioner.id == @player.id ? 'You' : league.commissioner.name,
      :action => :tapped,
      :arguments => {:type => type, :league => league},
      :cell_style => UITableViewCellStyleSubtitle,
      :accessory_type => UITableViewCellAccessoryDisclosureIndicator,
    }
  end
end
