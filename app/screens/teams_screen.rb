class TeamsScreen < UITableViewController
  attr_accessor :reuse_id, :league, :signedin_player

  def viewDidLoad
    super
    setup_navbar
    setup_table
  end

  def setup_navbar
    navigationItem.title = 'Teams'
    navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemAdd, target:self, action: :create_team)
  end

  def create_team
    navigationController << CreateTeamScreen.new(league: @league, creater: @signedin_player)
  end

  def setup_table
    @reuse_id = 'team cell'
    tableView.backgroundColor = BackgroundColor
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone
    refresh_team_list
  end

  def refresh_team_list
    @league.current_season.get_teams(@signedin_player) do
      tableView.reloadData
    end
  end

  # table view data source & delegate methods
  def numberOfSectionsIn(table_view)
    1
  end

  def tableView(table_view, numberOfRowsInSection:section)
    @league.current_season.teams ? @league.current_season.teams.length : 0
  end

  def tableView(table_view, didSelectRowAtIndexPath:index_path)
    tableView.deselectRowAtIndexPath(index_path, animated:true)
  end

  def tableView(table_view, heightForRowAtIndexPath: index_path)
    150
  end
end
