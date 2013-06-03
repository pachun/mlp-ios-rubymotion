class CreateSeasonScreen < Formotion::FormController
  include ProMotion::ScreenModule
  attr_accessor :form, :league, :leagues_screen

  def init
    setup_navbar
    build_form
    enable_create_button
    initWithForm(@form)
  end

  private

  def setup_navbar
    navigationItem.hidesBackButton = true
    navigationItem.title = 'New Season'
  end

  def enable_create_button
    @form.on_submit { create_season }
  end

  def disable_create_button
    @form.on_submit {}
  end

  def create_season
    disable_create_button
    @season = Season.new
    @season.name = @form.render[:name]
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
        SVProgressHUD.showSuccessWithStatus("Created #{@season.name}!")
        open InvitePlayersToLeagueScreen.new(league: @league, leagues_screen: @leagues_screen)
      end
    end
  end
end
