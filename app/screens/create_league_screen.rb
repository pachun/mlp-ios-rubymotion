class CreateLeagueScreen < Formotion::FormController
  include ProMotion::ScreenModule
  attr_accessor :form, :league, :player, :leagues_screen

  def init
    navigationItem.title = 'New League'
    build_form
    enable_create_button
    initWithForm(@form)
  end

  private

  def create_league
    disable_create_button
    @league = League.new
    @league.commissioner = @player
    @league.name = @form.render[:name]
    @league.plays_balls_back = @form.render[:plays_balls_back]
    @league.players_per_team = @form.render[:players_per_team].to_i
    @league.rerack_cups_from_fm = @form.render[:rerack_cups]
    @league.extra_point_cups_from_fm = @form.render[:extra_point_cups]
    @league.create do
      if league.created?
        SVProgressHUD.showSuccessWithStatus("Created #{@league.name}!")
        open_create_season_screen
      else
        SVProgressHUD.showErrorWithStatus(@league.error)
        enable_create_button
      end
    end
  end

  def open_create_season_screen
    create_season_screen = CreateSeasonScreen.new
    create_season_screen.league = @league
    create_season_screen.leagues_screen = @leagues_screen
    open create_season_screen
  end

  def enable_create_button
    @form.on_submit { create_league }
  end

  def disable_create_button
    @form.on_submit {}
  end
end
