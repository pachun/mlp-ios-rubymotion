class InvitesScreen < UITableViewController
  attr_accessor :reuse_id, :league, :signedin_player, :pending_teams
  stylesheet :team_invite_cell_sheet

  def viewDidLoad
    super
    setup_navbar
    setup_table
  end

  def viewWillAppear(animated)
    super(animated)
    refresh_invited_teams
  end

  private

  def setup_navbar
    navigationItem.title = 'Team Invitations'
    navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemAdd, target:self, action: :create_team)
  end

  def back_to_leagues
    dismiss_modal
  end

  def setup_table
    @reuse_id = 'invitation cell'
    tableView.backgroundColor = BackgroundColor
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone
  end

  def create_team
    if !@league.current_season.teams_locked
      navigationController << CreateTeamScreen.new(league: @league, creater: @signedin_player)
    else
      SVProgressHUD.showErrorWithStatus('The commissioner has locked the teams!')
    end
  end

  def refresh_invited_teams
    @signedin_player.populate_invited_teams(@league.current_season) do
      tableView.reloadData
    end
  end

  def numberOfSectionsIn(table_view)
    1
  end

  def tableView(table_view, numberOfRowsInSection:section)
    @signedin_player.invited_teams.nil? ? 0 : @signedin_player.invited_teams.count
  end

  def tableView(table_view, didSelectRowAtIndexPath:index_path)
    tableView.deselectRowAtIndexPath(index_path, animated:true)
    team_invitation_screen = TeamInvitationScreen.new
    team_invitation_screen.signedin_player = @signedin_player
    team_invitation_screen.team = @signedin_player.invited_teams[index_path.row]
    navigationController << team_invitation_screen
  end

  def tableView(table_view, heightForRowAtIndexPath: index_path)
    100
  end

  def tableView(table_view, cellForRowAtIndexPath:index_path)
    cell = recycled_cell
    cell = new_cell if cell.nil?
    team = @signedin_player.invited_teams[index_path.row]
    player1 = team.players[0]
    player2 = team.players[1]
    player3 = team.players[2] if @league.players_per_team == 3
    layout(cell.contentView, :cell) do
      subview(UIView, :team_card) do
        subview(UILabel, :team_name, :text => team.name)
        subview(UILabel, :player1_name, :text => player1.name)
        subview(UILabel, :player2_name, :text => player2.name)
        subview(UILabel, :player3_name, :text => player3.name) if @league.players_per_team == 3
        if team.nullified?
          subview(UILabel, :rejected)
        elsif team.finalized?
          subview(UILabel, :accepted)
        else
          subview(UILabel, :incomplete)
        end
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
