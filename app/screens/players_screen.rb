class PlayersScreen < UITableViewController
  attr_accessor :reuse_id, :league, :player
  stylesheet :players_sheet

  def viewDidLoad
    super
    setup_navbar
    setup_table
  end

  # navbar setup & actions
  def setup_navbar
    navigationItem.title = 'Players'
    navigationItem.leftBarButtonItem = UIBarButtonItem.alloc.initWithTitle('Back', style:UIBarButtonItemStyleDone, target:self, action: :back_to_leagues)
  end

  def back_to_leagues
    dismiss_modal
  end

  # table setup
  def setup_table
    tableView.backgroundColor = BackgroundColor
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone
    @reuse_id = 'player cell'
    refresh_player_list
  end

  def refresh_player_list
    @league.get_players(@player) do
      tableView.reloadData
    end
  end

  # table view data source & delegate methods
  def numberOfSectionsIn(table_view)
    1
  end

  def tableView(table_view, numberOfRowsInSection:section)
    @league.players ? @league.players.length : 0
  end

  def tableView(table_view, didSelectRowAtIndexPath:index_path)
    tableView.deselectRowAtIndexPath(index_path, animated:true)
  end

  def tableView(table_view, heightForRowAtIndexPath: index_path)
    100
  end

  # cell generating methods
  def tableView(table_view, cellForRowAtIndexPath:index_path)
    cell = recycled_cell
    cell = new_cell if cell.nil?
    player = @league.players[index_path.row]
    layout(cell.contentView, :cell) do
      subview(UIView, :player_card) do
        subview(UIImageView, :player_image, :image => player.gravatar)
        subview(UILabel, :player_name, :text => player.name)
        subview(UILabel, :player_team, :text => 'Free Agent') # fix after teams invites setup
        subview(UILabel, :player_hit_percentage, :text => '0.48 hit percentage')
        subview(UILabel, :player_point_percentage, :text => '0.62 point percentage')
      end
    end
    cell.apply_constraints
    cell
  end

  def recycled_cell
    tableView.dequeueReusableCellWithIdentifier(@reuse_id)
  end

  def new_cell
    cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuse_id)
    cell.selectionStyle = UITableViewCellSelectionStyleGray
    cell
  end
end