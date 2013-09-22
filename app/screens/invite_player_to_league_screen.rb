class InvitePlayersToLeagueScreen < ProMotion::TableScreen
  attr_accessor :league, :table_data, :delegate

  def on_load
    setup_navbar
    refresh_table_cells
  end

  def tapped(player)
    first_name = player.name.split(' ').first
    if player.accepted_invite
      UIAlertView.alert "You can't remove #{first_name}"
    elsif player.invited && !player.accepted_invite
      UIAlertView.alert "You can't uninvite #{first_name}"
    else
      confirm_invite_for(player)
    end
  end

  private

  def setup_navbar
    navigationItem.hidesBackButton = true
    navigationItem.title = "Invite Players"
    set_nav_bar_right_button "Save", action: :done_inviting_players, type: UIBarButtonItemStyleDone
  end

  def done_inviting_players
    @delegate.done_with_invitations
  end

  def refresh_table_cells
    cells = @league.invitable_players.map{ |player| cell_for(player) }
    @table_data = [{:cells => cells}]
  end

  def update_table_data
    @league.populate_invitable_players do
      refresh_table_cells
      super
    end
  end

  def cell_for(player)
    cell = {:title => player.name,
            :action => :tapped,
            :arguments => player,
            :cell_style => UITableViewCellStyleSubtitle,
    }
    if player.accepted_invite
      cell[:subtitle] = 'member'
      cell[:accessory_type] = UITableViewCellAccessoryCheckmark
    elsif player.invited
      cell[:subtitle] = 'invited'
      cell[:accessory_type] = UITableViewCellAccessoryNone
    end
    cell
  end

  def confirm_invite_for(player)
    UIAlertView.alert("Invite #{player.name}?", buttons: ['Yes', 'No']) do |button|
      invite(player) if button == 'Yes'
    end
  end

  def invite(player)
    @league.invite(player) do
      if player.invited
        update_table_data
      else
        SVProgressHUD.showErrorWithStatus("Couldn't invite #{player.name}")
        update_table_data
      end
    end
  end
end
