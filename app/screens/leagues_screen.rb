class LeaguesScreen < ProMotion::SectionedTableScreen
  attr_accessor :player, :table_data

  title 'Welcome'

  def on_load
    set_nav_bar_left_button('Sign Out', action: :logout)
    set_nav_bar_right_button(nil, action: :create_league, system_icon: UIBarButtonSystemItemAdd)
    @table_data = [{title: 'Leagues', cells: []},
                   {title: 'Invites', cells: []},
    ]
  end

  def will_appear
    populate_leagues
    populate_invites
  end

  # cell tap actions
  def league_tapped(args={})
    puts "league tapped"
  end

  def invite_tapped(args={})
    open LeaguePlayerInviteScreen.new(player: @player, league: args[:league])
  end

  private

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
      cells = []
      @player.league_invites.each do |league|
        cells << cell_for_league(league, :invitee)
      end
      @table_data.last[:cells] = cells
      update_table_data
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
