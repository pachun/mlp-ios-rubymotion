class GameOverviewScreen < ProMotion::Screen
  attr_accessor :game, :rounds_table

  title 'Game Report'
  stylesheet :game_overview_sheet
  layout :root do
    @rounds_table = subview UITableView, :rounds_table, :dataSource => self, :delegate => self, :hidden => true
    subview UIView, :header do
      subview UIImageView, :home_team_p1_icon, :image => @game.home_team_players[0].gravatar
      subview UILabel, :"home_team_p1_name", :text => @game.home_team_players[0].name.split(' ').join("\n")

      subview UIImageView, :"home_team_p2_icon", :image => @game.home_team_players[1].gravatar
      subview UILabel, :"home_team_p2_name", :text => @game.home_team_players[1].name.split(' ').join("\n")

      subview UIImageView, :"away_team_p1_icon", :image => @game.away_team_players[0].gravatar
      subview UILabel, :"away_team_p1_name", :text => @game.away_team_players[0].name.split(' ').join("\n")

      subview UIImageView, :"away_team_p2_icon", :image => @game.away_team_players[1].gravatar
      subview UILabel, :"away_team_p2_name", :text => @game.away_team_players[1].name.split(' ').join("\n")

      if @game.season.league.players_per_team == 3
        subview UIImageView, :"home_team_p3_icon", :image => @game.home_team_players[2].gravatar
        subview UILabel, :"home_team_p3_name", :text => @game.home_team_players[2].name.split(' ').join("\n")

        subview UIImageView, :"away_team_p3_icon", :image => @game.away_team_players[2].gravatar
        subview UILabel, :"away_team_p3_name", :text => @game.away_team_players[2].name.split(' ').join("\n")
      end

      subview UILabel, :home_team_name, :text => @game.home_team.name
      subview UILabel, :away_team_name, :text => @game.away_team.name
      # subview UILabel, :round_number_label
    end
  end

  def viewDidLoad
    super
    navigationItem.leftBarButtonItem = UIBarButtonItem.alloc.initWithImage('back_arrow.png'.uiimage, style:UIBarButtonItemStylePlain, target:self, action: :go_to_games_list)
  end

  def numberOfSectionsInTableView(table_view)
    1
  end

  def tableView(table_view, numberOfRowsInSection:section)
    @game.rounds.count
  end

  def tableView(table_view, didSelectRowAtIndexPath:index_path)
    table_view.deselectRowAtIndexPath(index_path, animated:false)
  end

  def tableView(table_view, cellForRowAtIndexPath:index_path)
    cell = table_view.dequeueReusableCellWithIdentifier('round cell')
    cell ||= UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:'round cell')
    cell.contentView.backgroundColor = BlueColor.colorWithAlphaComponent(0.05) if index_path.row % 2 == 0
    fill cell, at:index_path.row
    cell
  end

  def tableView(table_view, heightForRowAtIndexPath:index_path)
    30
  end

  def tableView(table_view, heightForHeaderInSection:section)
    0
  end

  private

  def go_to_games_list
    dismiss_modal
  end

  def home_shots_for(turn)
    layout UIView, :home_shots_panel do
      subview UILabel, :home_p1_score, :text => turn.cup_hit_by(@game.home_team_players[0])
      subview UILabel, :home_p2_score, :text => turn.cup_hit_by(@game.home_team_players[1])
      if @game.season.league.players_per_team == 3
        subview UILabel, :home_p3_score, :text => turn.cup_hit_by(@game.home_team_players[2])
      end
    end
  end

  def away_shots_for(turn)
    layout UIView, :away_shots_panel do
      subview UILabel, :away_p1_score, :text => turn.cup_hit_by(@game.away_team_players[0])
      subview UILabel, :away_p2_score, :text => turn.cup_hit_by(@game.away_team_players[1])
      if @game.season.league.players_per_team == 3
        subview UILabel, :away_p3_score, :text => turn.cup_hit_by(@game.away_team_players[2])
      end
    end
  end

  def fill(cell, at:location)
    round = @game.rounds[location]
    2.times do |turn_num|
      turn = turn_num == 0 ? round.first_turn : round.second_turn
      unless turn.nil?
        if turn.team.id == @game.home_team.id
          cell.contentView << home_shots_for(turn)
        else
          cell.contentView << away_shots_for(turn)
        end
      end
    end
    cell.contentView << (layout UILabel, :round_number, :text => (location + 1).to_s)
    cell.contentView.apply_constraints
  end
end
