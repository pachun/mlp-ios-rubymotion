class LeaguesScreen < ProMotion::TableScreen
  attr_accessor :signedin_player, :table_data, :selected_league

  title 'Leagues'

  def on_load
    setup_navbar
    @table_data = [{cells: []}]
    self.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal
  end

  def will_appear
    view.backgroundColor = BackgroundColor
    SVProgressHUD.showWithMaskType SVProgressHUDMaskTypeGradient
    populate_leagues do
      populate_invites do
        SVProgressHUD.dismiss
      end
    end
  end

  def tapped(touched)
    if touched[:type] == :league
      @selected_league = touched[:league]
      open_league_overview
    elsif touched[:type] == :invite
      open LeaguePlayerInviteScreen.new(signedin_player: @signedin_player, league: touched[:league])
    end
  end

  private

  def setup_navbar
    navigationItem.leftBarButtonItem = UIBarButtonItem.alloc.initWithImage('back_arrow.png'.uiimage, style:UIBarButtonItemStylePlain, target:self, action: :logout)
    set_nav_bar_right_button(nil, action: :create_league, system_icon: UIBarButtonSystemItemAdd)
  end

  def logout
    dismiss_modal
  end

  def create_league
    nav = UINavigationController.alloc.initWithRootViewController(create_league_screen)
    present_modal nav
  end

  def create_league_screen
    @create_league_screen = CreateLeagueScreen.new
    @create_league_screen.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal
    @create_league_screen.signedin_player = @signedin_player
    @create_league_screen.leagues_screen = self
    @create_league_screen
  end

  def open_league_overview
    tab_bar = UITabBarController.new
    tab_bar.viewControllers = [players_tab, teams_tab, games_tab, invites_tab, options_tab]
    present_modal(tab_bar)
  end

  def players_tab
    screen = PlayersScreen.new
    screen.league = @selected_league
    screen.signedin_player = @signedin_player
    tab = UITabBarItem.alloc.initWithTitle('Players', image:'players.png'.uiimage, tag:0)
    screen.setTabBarItem(tab)
    UINavigationController.new << screen
  end

  def teams_tab
    screen = TeamsScreen.new
    screen.league = @selected_league
    screen.signedin_player = @signedin_player
    tab = UITabBarItem.alloc.initWithTitle('Teams', image:'teams.png'.uiimage, tag:0)
    screen.setTabBarItem(tab)
    UINavigationController.new << screen
  end

  def games_tab
    screen = GamesScreen.new
    screen.league = @selected_league
    screen.signedin_player = @signedin_player
    tab = UITabBarItem.alloc.initWithTitle('Games', image:'games.png'.uiimage, tag:0)
    screen.setTabBarItem(tab)
    UINavigationController.new << screen
  end

  def invites_tab
    screen = InvitesScreen.new
    screen.league = @selected_league
    screen.signedin_player = @signedin_player
    tab = UITabBarItem.alloc.initWithTitle('Invites', image:'invites.png'.uiimage, tag:0)
    screen.setTabBarItem(tab)
    UINavigationController.new << screen
  end

  def options_tab
    screen = OptionsScreen.new
    screen.league = @selected_league
    screen.signedin_player = @signedin_player
    tab = UITabBarItem.alloc.initWithTitle('Options', image:'options.png'.uiimage, tag:0)
    screen.setTabBarItem(tab)
    UINavigationController.new << screen
  end

  def populate_leagues(&block)
    @signedin_player.populate_leagues do
      cells = @signedin_player.leagues.map { |league| cell_for(:league, league) }
      @table_data.first[:cells] = cells
      update_table_data
      block.call
    end
  end

  def populate_invites(&block)
    @signedin_player.populate_invited_leagues do
      if @signedin_player.invited_leagues.count > 0
        cells = @signedin_player.invited_leagues.map { |league| cell_for(:invite, league) }
        @table_data[1] = {title: 'Invites', cells: cells}
      else
        @table_data.delete_at(1) if !@table_data[1].nil?
      end
      update_table_data
      block.call
    end
  end

  def cell_for(type, league)
    {
      :title => league.name,
      :subtitle => league.commissioner.id == @signedin_player.id ? 'You' : league.commissioner.name,
      :action => :tapped,
      :arguments => {:type => type, :league => league},
      :cell_style => UITableViewCellStyleSubtitle,
      :accessory_type => UITableViewCellAccessoryDisclosureIndicator,
    }
  end
end
