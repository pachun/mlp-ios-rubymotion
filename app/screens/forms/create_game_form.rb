class GamesScreen < UITableViewController

  def build_create_game_form
    team_rows = generate_team_rows
    @create_game_form = Formotion::Form.new({
      sections: [{
        rows: [{
          title: 'When',
          key: :scheduled_time,
          type: :date,
          format: :short,
          picker_mode: :date_time,
        }, {
          title: 'Home Team',
          type: :subform,
          display_key: :type,
          key: :home_team,
          subform: {
            title: 'Home Team',
            sections: [{
              select_one: true,
              key: :home_team,
              rows: team_rows,
            }]
          }
        }, {
          title: 'Away Team',
          type: :subform,
          display_key: :type,
          key: :away_team,
          subform: {
            title: 'Away Team',
            sections: [{
              select_one: true,
              key: :away_team,
              rows: team_rows,
            }]
          }
        }]
      }, {
        rows: [{
          title: 'Schedule Game',
          type: :submit,
        }]
      }]
    })
    @create_game_form.on_submit { create_game }
  end

  def generate_team_rows
    @league.current_season.teams.map do |team|
      {
        :title => team.name,
        :key => team.id.to_s,
        :type => :check,
      }
    end
  end
end
