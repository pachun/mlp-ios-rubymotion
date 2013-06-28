class GameSetupScreen < ProMotion::Screen
  attr_accessor :home_player_icons, :home_player_names, :away_player_icons, :away_player_names

  stylesheet :game_setup_sheet

  layout :root do
    @home_player_icons = []
    @home_player_names = []
    @away_player_icons = []
    @away_player_names = []
    subview(UIView, :home_team_bg) do
      @home_player_icons << subview(UIImageView, :player1_icon, :image => @game.home_team_players[0].gravatar)
      @home_player_icons << subview(UIImageView, :player2_icon, :image => @game.home_team_players[1].gravatar)
      @home_player_names << subview(UILabel, :player1_name, :text => @game.home_team_players[0].name)
      @home_player_names << subview(UILabel, :player2_name, :text => @game.home_team_players[1].name)
      if @game.season.league.players_per_team == 3
        @home_player_icons << subview(UIImageView, :player3_icon, :image => @game.home_team_players[2].gravatar)
        @home_player_names << subview(UILabel, :player3_name, :text => @game.home_team_players[2].name)
      end
      @home_starts_button = subview(UIButton.custom, :start_button)
    end
    subview(UIView, :away_team_bg) do
      @away_player_icons << subview(UIImageView, :player1_icon, :image => @game.away_team_players[0].gravatar)
      @away_player_icons << subview(UIImageView, :player2_icon, :image => @game.away_team_players[1].gravatar)
      @away_player_names << subview(UILabel, :player1_name, :text => @game.away_team_players[0].name)
      @away_player_names << subview(UILabel, :player2_name, :text => @game.away_team_players[1].name)
      if @game.season.league.players_per_team == 3
        @away_player_icons << subview(UIImageView, :player3_icon, :image => @game.away_team_players[2].gravatar)
        @away_player_names << subview(UILabel, :player3_name, :text => @game.away_team_players[2].name)
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
