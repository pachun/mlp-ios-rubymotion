class CreateTeamScreen < ProMotion::Screen
  attr_accessor :name_field, :invite_button,
    :teammate1_name, :teammate1_icon,
    :teammate2_name, :teammate2_icon

  stylesheet :create_team_sheet

  layout :root do
    subview(UIView, :name_box) do
      @name_field = subview(UITextField, :name_field)
    end

    subview(UILabel, :creater_name, :text => @creater.name)
    subview(UIImageView, :creater_icon, :image => @league.player_for(@creater).gravatar)

    @teammate1_name = subview(UILabel, :teammate1_name, :text => 'Second Player')
    @teammate1_icon = subview(UIImageView, :teammate1_icon)

    if @league.players_per_team == 3
      @teammate2_name = subview(UILabel, :teammate2_name, :text => 'Third Player')
      @teammate2_icon = subview(UIImageView, :teammate2_icon)
    end

    @invite_button = subview(UIButton.custom, :invite_button)
  end

  def layoutDidLoad
    @invite_button.setTitle('Invite Teammates', forState:UIControlStateNormal)
    @invite_button.setTitleColor(:white.uicolor, forState:UIControlStateNormal)
    did_load
  end
end
