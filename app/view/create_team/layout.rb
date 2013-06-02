class CreateTeamScreen < ProMotion::Screen
  attr_accessor :name_field, :invite_button,
    :player2_name, :player2_icon,
    :player3_name, :player3_icon

  stylesheet :create_team_sheet

  layout :root do
    subview(UIView, :name_box) do
      @name_field = subview(UITextField, :name_field)
    end

    subview(UILabel, :player1_name, :text => @creater.name)
    subview(UIImageView, :player1_icon, :image => @league.player_for(@creater).gravatar)

    @player2_name = subview(UILabel, :player2_name, :text => 'Second Player')
    @player2_icon = subview(UIImageView, :player2_icon)

    if @league.players_per_team == 3
      @player3_name = subview(UILabel, :player3_name, :text => 'Third Player')
      @player3_icon = subview(UIImageView, :player3_icon)
    end

    @invite_button = subview(UIButton.custom, :invite_button)
  end

  def layoutDidLoad
    @invite_button.setTitle('Invite Teammates', forState:UIControlStateNormal)
    @invite_button.setTitleColor(:white.uicolor, forState:UIControlStateNormal)
    did_load
  end
end
