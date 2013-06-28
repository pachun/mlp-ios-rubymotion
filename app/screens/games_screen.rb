class GamesScreen < UITableViewController
  attr_accessor :reuse_id, :league, :signedin_player, :create_game_form, :new_game
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
      navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemAdd, target:self, action: :check_if_teams_locked)
    end
  end

  def check_if_teams_locked
    if !@league.current_season.teams_locked
      UIAlertView.alert("You have to lock teams before scheduling games. This is irreversible. Continue?", buttons: ['Yes, Lock Teams', 'No']) do |button|
        if button == 'Yes, Lock Teams'
          @league.current_season.lock_teams(@signedin_player) do
            load_create_game_form
          end
        end
      end
    else
      load_create_game_form
    end
  end

  def load_create_game_form
    build_create_game_form
    navigationController << CreateGameScreen.alloc.initWithForm(@create_game_form)
  end

  def create_game
    @new_game = Game.new
    @new_game.season = @league.current_season
    @new_game.scheduled_time = @create_game_form.render[:scheduled_time]
    @new_game.home_team = @league.current_season.team_with_id(@create_game_form.render[:home_team][:home_team])
    @new_game.away_team = @league.current_season.team_with_id(@create_game_form.render[:away_team][:away_team])
    @new_game.create(@signedin_player) do
      if @new_game.created
        SVProgressHUD.showSuccessWithStatus('Game scheduled!')
        navigationController.pop
      else
        SVProgressHUD.showErrorWithStatus(@new_game.error)
      end
    end
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
        tableView.reloadData
      end
    end
  end

  def numberOfSectionsIn(table_view)
    1
  end

  def tableView(table_view, numberOfRowsInSection:section)
    @league.current_season.games.nil? ? 0 : @league.current_season.games.count
  end

  def tableView(table_view, didSelectRowAtIndexPath:index_path)
    if @league.commissioner.id == @signedin_player.id
      game = @league.current_season.games[index_path.row]
      game.ref = @signedin_player
      present_modal(game.navigation_stack.nav)
    else
      # show game overview
    end
  end

  def tableView(table_view, heightForRowAtIndexPath: index_path)
    100
  end

  def tableView(table_view, cellForRowAtIndexPath:index_path)
    cell = recycled_cell
    cell = new_cell if cell.nil?
    game = @league.current_season.games[index_path.row]
    layout(cell.contentView, :cell) do
      subview(UIView, :game_card) do
        subview(UILabel, :home_team_name, :text => game.home_team.name)
        subview(UILabel, :vs_label)
        subview(UILabel, :away_team_name, :text => game.away_team.name)
      end
    end
    cell.contentView.apply_constraints
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
