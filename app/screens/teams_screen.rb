class TeamsScreen < UITableViewController
  attr_accessor :reuse_id, :league, :signedin_player
  stylesheet :team_cell_sheet

  def viewDidLoad
    super
    setup_navbar
    setup_table
  end

  private

  def setup_navbar
    navigationItem.title = 'Teams'
    navigationItem.leftBarButtonItem = UIBarButtonItem.alloc.initWithTitle('Leagues', style:UIBarButtonItemStylePlain, target:self, action: :back_to_leagues)
  end

  def back_to_leagues
    dismiss_modal
  end

  def setup_table
    @reuse_id = 'team cell'
    tableView.backgroundColor = BackgroundColor
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone
    refresh_team_list if @league.current_season.teams.nil?
  end

  def refresh_team_list
    @league.current_season.populate_teams(@signedin_player) do
      tableView.reloadData
    end
  end

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
    100
  end

  def tableView(table_view, cellForRowAtIndexPath:index_path)
    cell = recycled_cell
    cell = new_cell if cell.nil?
    team = league.current_season.teams[index_path.row]
    player1 = team.players[0]
    player2 = team.players[1]
    player3 = team.players[2] if @league.players_per_team == 3
    layout(cell.contentView, :cell) do
      subview(UIView, :team_card) do
        subview(UILabel, :team_name, :text => team.name)
        subview(UILabel, :player1_name, :text => player1.name)
        subview(UILabel, :player2_name, :text => player2.name)
        subview(UILabel, :player3_name, :text => player3.name) if @league.players_per_team == 3
        subview(UILabel, :wins_label, :text => "#{team.wins} wins")
        subview(UILabel, :losses_label, :text => "#{team.losses} losses")
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
