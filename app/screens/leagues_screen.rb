class LeaguesScreen < ProMotion::SectionedTableScreen
  attr_accessor :player, :table_data, :selected_league

  title 'Leagues'

  def on_load
    set_nav_bar_left_button('Sign Out', action: :logout)
    set_nav_bar_right_button(nil, action: :create_league, system_icon: UIBarButtonSystemItemAdd)
    @table_data = [{cells: []}]
  end

  def will_appear
    populate_leagues
    populate_invites
  end

  # cell tap actions
  def league_tapped(args={})
    @selected_league = args[:league]
    # players, teams, games (played | unplayed), invites, more (league rules, past season stats)
    tab_bar = UITabBarController.new
    tab_bar.viewControllers = [players_nav, teams_nav, games_nav, invites_nav, more_nav]
    present_modal(tab_bar)
  end

  def invite_tapped(args={})
    open LeaguePlayerInviteScreen.new(player: @player, league: args[:league])
  end

  private

  # tab bar screens
  def players_nav
    screen = PlayersScreen.new
    screen.league = @selected_league
    screen.player = @player
    tab = UITabBarItem.alloc.initWithTitle('Players', image:'players.png'.uiimage, tag:0)
    screen.setTabBarItem(tab)
    nav = UINavigationController.new
    nav << screen
    nav
  end

  def teams_nav
    screen = TeamsScreen.new
    screen.league = @league
    tab = UITabBarItem.alloc.initWithTitle('Teams', image:'teams.png'.uiimage, tag:0)
    screen.setTabBarItem(tab)
    nav = UINavigationController.new
    nav << screen
    nav
  end

  def games_nav
    screen = GamesScreen.new
    screen.league = @league
    tab = UITabBarItem.alloc.initWithTitle('Games', image:'games.png'.uiimage, tag:0)
    screen.setTabBarItem(tab)
    nav = UINavigationController.new
    nav << screen
    nav
  end

  def invites_nav
    screen = InvitesScreen.new
    screen.league = @league
    tab = UITabBarItem.alloc.initWithTitle('Invites', image:'invites.png'.uiimage, tag:0)
    screen.setTabBarItem(tab)
    nav = UINavigationController.new
    nav << screen
    nav
  end

  def more_nav
    screen = MoreScreen.new
    screen.league = @league
    tab = UITabBarItem.alloc.initWithTitle('More', image:'more.png'.uiimage, tag:0)
    screen.setTabBarItem(tab)
    nav = UINavigationController.new
    nav << screen
    nav
  end

  # league / invite cell info updaters
  def populate_leagues
    @player.populate_leagues do
      cells = []
      @player.leagues.each do |league|
        cells << cell_for_league(league, :member)
      end
      @table_data.first[:cells] = cells
      update_table_data
    end
  end

  def populate_invites
    @player.populate_invites do
      if @player.league_invites.count > 0
        cells = []
        @player.league_invites.each do |league|
          cells << cell_for_league(league, :invitee)
        end
        @table_data[1] = {title: 'Invites', cells: cells}
        update_table_data
      end
    end
  end

  def cell_for_league(league, status)
    {
      :title => league.name,
      :subtitle => league.commissioner.id == player.id ? 'You' : league.commissioner.name,
      :action => status == :member ? :league_tapped : :invite_tapped,
      :arguments => {league: league},
      :cell_style => UITableViewCellStyleSubtitle,
      :accessory_type => UITableViewCellAccessoryDisclosureIndicator,
    }
  end

  # nav bar button actions
  def logout
    dismiss_modal
  end

  def create_league
    create_league_screen = CreateLeagueScreen.new
    create_league_screen.player = @player
    create_league_screen.leagues_screen = self
    open create_league_screen
  end
end
