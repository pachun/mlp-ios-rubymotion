class InvitePlayersToLeagueScreen < ProMotion::TableScreen
  attr_accessor :league, :table_data, :leagues_screen

  def on_load
    navigationItem.hidesBackButton = true
    navigationItem.title = @league.name
    set_nav_bar_right_button "Done", action: :back_to_leagues_screen, type: UIBarButtonItemStyleDone
    update_table_data
  end

  def back_to_leagues_screen
    navigationController.pop @leagues_screen
  end

  # table methods
  def table_data
    @table_data
  end

  def name_tapped(args={})
    player = args[:player]
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

  def update_table_data
    @league.populate_invitable_players do
      cells = []
      @league.invitable_players.each { |player| cells << cell_for(player) }
      @table_data = [{:cells => cells}]
      super
    end
  end

  def cell_for(player)
    cell = {:title => player.name,
            :action => :name_tapped,
            :arguments => {:player => player},
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

  # actual inviting done here
  def confirm_invite_for(player)
    UIAlertView.alert("Invite #{player.name}?", buttons: ['Yes', 'No']) do |button|
      if button == 'Yes'
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
  end
end
