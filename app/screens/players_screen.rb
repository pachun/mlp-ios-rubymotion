class PlayersScreen < UITableViewController
  attr_accessor :reuse_id, :league, :signedin_player
  stylesheet :player_cell_sheet

  def viewDidLoad
    super
    setup_navbar
    setup_table
  end

  def setup_navbar
    navigationItem.title = 'Players'
  end

  def back_to_leagues
    dismiss_modal
  end

  def setup_table
    @reuse_id = 'player cell'
    tableView.backgroundColor = BackgroundColor
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone
    refresh_player_list
  end

  def refresh_player_list
    SVProgressHUD.showWithStatus('', maskType:SVProgressHUDMaskTypeGradient)
    @league.get_players(@signedin_player) do
      SVProgressHUD.dismiss
      tableView.reloadData
    end
  end

  def numberOfSectionsIn(table_view)
    1
  end

  def tableView(table_view, numberOfRowsInSection:section)
    @league.players ? @league.players.length : 0
  end

  def tableView(table_view, didSelectRowAtIndexPath:index_path)
    player = @league.players[index_path.row]
    player_vc = PlayerDetailsScreen.new
    player_vc.player = player
    navigationController << player_vc
  end

  def tableView(table_view, heightForRowAtIndexPath: index_path)
    100
  end

  def tableView(table_view, cellForRowAtIndexPath:index_path)
    cell = recycled_cell
    cell = new_cell if cell.nil?
    player = @league.players[index_path.row]
    layout(cell.contentView, :cell) do
      subview(UIView, :player_card) do
        subview(UIImageView, :player_image, :image => player.gravatar)
        subview(UILabel, :player_name, :text => player.name)
        subview(UILabel, :player_team, :text => 'Free Agent') # fix after teams invites setup
        subview(UILabel, :player_hit_percentage, :text => "#{player.shp.round(2)} hit percentage")
        subview(UILabel, :player_point_percentage, :text => "#{player.spp.round(2)} point percentage")
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
