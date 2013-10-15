class GamesScreen < UITableViewController
  attr_accessor :reuse_id, :league, :signedin_player, :create_game_form, :games_by_date
  stylesheet :game_cell_sheet

  def viewDidLoad
    super
    setup_navbar
    setup_table
  end

  def viewWillAppear(animated)
    super(animated)
    refresh_game_list
  end

  def setup_navbar
    navigationItem.title = 'Games'
    if @league.commissioner.id == @signedin_player.id
      navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemAdd, target:self, action: :go_to_create_game_screen)
    end
  end

  def lock_teams
    @league.current_season.lock_teams(@signedin_player)
  end

  def teams_unlocked?
    !@league.current_season.teams_locked
  end

  def ask_to_lock_teams
    UIAlertView.alert("You have to lock teams before scheduling games. This is irreversible. Continue?", buttons: ['Yes, Lock Teams', 'No']) do |button|
      lock_teams if button == 'Yes, Lock Teams'
    end
  end

  def go_to_create_game_screen
    ask_to_lock_teams if teams_unlocked?
    create_game unless teams_unlocked?
  end

  def create_game_screen
    screen = CreateGameScreen.new
    screen.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal
    screen.signedin_player = @signedin_player
    screen.season = @league.current_season
    screen
  end

  def create_game
    nav = UINavigationController.alloc.initWithRootViewController(create_game_screen)
    present_modal nav
  end

  def back_to_leagues
    dismiss_modal
  end

  def setup_table
    @reuse_id = 'game cell'
    tableView.backgroundColor = BackgroundColor
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone
  end

  def refresh_game_list
    @league.current_season.populate_teams(@signedin_player) do
      @league.current_season.populate_games(@signedin_player) do
        sort_games_by_date
        tableView.reloadData
      end
    end
  end

  def sort_games_by_date
    sort_unique_dates
    @league.current_season.games.each do |game|
      @organized_games.each_pair do |date, games|
        if date.same_day? game.scheduled_time
          games << game
          break
        end
      end
    end
  end

  def sort_unique_dates
    all_games = @league.current_season.games
    dates = all_games.map{ |g| g.scheduled_time }
    dates.sort!.reverse!
    collapse(dates)
  end

  def collapse(dates)
    @organized_games = {}
    @organized_games[dates.first] = []
    dates.each do |date|
      last_date = @organized_games.keys.last
      @organized_games[date] = [] unless last_date.same_day?(date)
    end
  end

  def numberOfSectionsInTableView(table_view)
    # 1
    @organized_games.nil? ? 0 : @organized_games.keys.count
  end

  def tableView(table_view, numberOfRowsInSection:section)
    # @league.current_season.games.nil? ? 0 : @league.current_season.games.count
    @league.current_season.games.nil? ? 0 : @organized_games[@organized_games.keys[section]].count
  end

  def tableView(table_view, heightForHeaderInSection: section)
    30
  end

  def tableView(table_view, viewForHeaderInSection:section)
    if @organized_games
      UIView.alloc.init.tap do |header|
        header.frame = [[0,0],[320,60]]
        header.backgroundColor = BackgroundColor
        header << header_label_in_section(section)
      end
    else
      UIView.new
    end
  end

  def header_label_in_section(section)
    UILabel.alloc.init.tap do |header|
      header.frame = [[10,5],[300,20]]
      header.font = :bold.uifont(12)
      header.text = @organized_games.keys[section].string_with_format('MMMM d, yyyy')
    end
  end

  def tableView(table_view, didSelectRowAtIndexPath:index_path)
    game = game_at_path(index_path)
    if @league.commissioner.id == @signedin_player.id && !game.was_played
      game.setup_with_ref(@signedin_player)
      present_modal game.navigation_stack.nav
    else
      game.populate_details(@signedin_player) do
        game_overview_screen = GameOverviewScreen.new
        game_overview_screen.game = game
        nav = UINavigationController.alloc.initWithRootViewController game_overview_screen
        present_modal nav
      end
    end
  end

  def tableView(table_view, heightForRowAtIndexPath: index_path)
    100
  end

  def game_at_path(path)
    date = @organized_games.keys[path.section]
    @organized_games[date][path.row]
  end

  def tableView(table_view, cellForRowAtIndexPath:index_path)
    cell = recycled_cell
    cell = new_cell if cell.nil?
    unless @organized_games.nil?
      game = game_at_path(index_path)
      layout(cell.contentView, :cell) do
        subview(UIView, :game_card) do
          game_time = game.scheduled_time.string_with_format('hh:mma')
          subview(UILabel, :game_time, :text => game_time)
          subview(UILabel, :home_team_name, :text => game.home_team.name)
          subview(UILabel, :vs_label)
          subview(UILabel, :away_team_name, :text => game.away_team.name)
        end
      end
      cell.contentView.apply_constraints
    end
    cell
  end

  def recycled_cell
    tableView.dequeueReusableCellWithIdentifier(@reuse_id)
  end

  def new_cell
    cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuse_id)
    cell.selectionStyle = UITableViewCellSelectionStyleNone
    cell
  end
end
