class CreateLeagueScreen < PM::FormotionScreen
  attr_accessor :signedin_player, :league, :leagues_screen, :form

  title 'New League'

  def viewDidLoad
    super
    navigationItem.leftBarButtonItem = UIBarButtonItem.alloc.initWithImage('back_arrow.png'.uiimage, style:UIBarButtonItemStylePlain, target:self, action: :go_back_to_leagues_screen)
  end

  def table_data
    @form = CreateLeagueForm
    append_season_creation_form
    append_submit_button
    @form = Formotion::Form.new(@form)
    enable_create_button
    @form
  end

  def done_with_invitations
    dismiss_modal
  end

  private

  def go_back_to_leagues_screen
    dismiss_modal
  end

  def append_season_creation_form
    new_season_form = CreateSeasonForm
    new_season_form[:sections].pop
    @form[:sections].concat(new_season_form[:sections])
  end

  def append_submit_button
    if @form[:sections].count == 2
      @form[:sections] << {rows: [{title: 'Create', type: :submit}]}
    end
  end

  def create_league
    disable_create_button
    @league = League.new
    @league.commissioner = @signedin_player
    @league.name = @form.render[:league_name]
    @league.plays_balls_back = @form.render[:plays_balls_back]
    @league.players_per_team = @form.render[:players_per_team].to_i
    @league.rerack_cups_from_fm = @form.render[:rerack_cups]
    @league.extra_point_cups_from_fm = @form.render[:extra_point_cups]
    @league.create do
      if league.created?
        SVProgressHUD.showSuccessWithStatus("Created #{@league.name}!")
        create_season
      else
        SVProgressHUD.showErrorWithStatus(@league.error)
        enable_create_button
      end
    end
  end

  def create_season
    @season = Season.new
    @season.name = @form.render[:season_name]
    @season.league = @league
    @season.create do
      if @season.created
        update_leagues_current_season
      else
        SVProgressHUD.showErrorWithStatus(@season.error)
        enable_create_button
      end
    end
  end

  def update_leagues_current_season
    @league.set_current_season(@season) do
      if @league.updated
        SVProgressHUD.showSuccessWithStatus("Created #{@season.name} in #{@league.name}")
        invite_players
      end
    end
  end

  def invite_players
    @league.populate_invitable_players(@signedin_player) do
      open InvitePlayersToLeagueScreen.new(league: @league, signedin_player: @signedin_player, delegate: self)
    end
  end

  def enable_create_button
    @form.on_submit { create_league }
  end

  def disable_create_button
    @form.on_submit {}
  end
end
