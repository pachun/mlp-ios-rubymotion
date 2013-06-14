class GameSetupScreen < ProMotion::Screen
  stylesheet :game_setup_sheet

  layout :root do
    subview(UIView, :home_team_bg) do
      subview(UIImageView, :player1_icon, :image => @game.home_team.players[0].gravatar)
      subview(UIImageView, :player2_icon, :image => @game.home_team.players[1].gravatar)
      subview(UILabel, :player1_name, :text => @game.home_team.players[0].name)
      subview(UILabel, :player2_name, :text => @game.home_team.players[1].name)
      if @game.season.league.players_per_team == 3
        subview(UIImageView, :player3_icon, :image => @game.home_team.players[2].gravatar)
        subview(UILabel, :player3_name, :text => @game.home_team.players[2].name)
      end
      @home_starts_button = subview(UIButton.custom, :start_button)
    end
    subview(UIView, :away_team_bg) do
      subview(UIImageView, :player1_icon, :image => @game.away_team.players[0].gravatar)
      subview(UIImageView, :player2_icon, :image => @game.away_team.players[1].gravatar)
      subview(UILabel, :player1_name, :text => @game.away_team.players[0].name)
      subview(UILabel, :player2_name, :text => @game.away_team.players[1].name)
      if @game.season.league.players_per_team == 3
        subview(UIImageView, :player3_icon, :image => @game.away_team.players[2].gravatar)
        subview(UILabel, :player3_name, :text => @game.away_team.players[2].name)
      end
      @away_starts_button = subview(UIButton.custom, :start_button)
    end
  end

  def layoutDidLoad
    @home_starts_button.setTitle('Shoot First', forState:UIControlStateNormal)
    @home_starts_button.setTitleColor(:white.uicolor, forState:UIControlStateNormal)
    @away_starts_button.setTitle('Shoot First', forState:UIControlStateNormal)
    @away_starts_button.setTitleColor(:white.uicolor, forState:UIControlStateNormal)
  end
end
