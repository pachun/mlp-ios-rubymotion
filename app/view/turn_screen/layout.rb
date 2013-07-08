class TurnScreen < PM::Screen
  attr_accessor :panels, :hit_buttons, :miss_buttons, :hit_cup_labels
  stylesheet :turn_screen_sheet

  layout :root do
    @panels = []
    @names = []
    @hit_buttons = []
    @miss_buttons = []
    @hit_cup_labels = []
    if @num_shots == 3
      @panels << subview(UIView, :one_of_three) do
        subview(UIImageView, :player_image, :image => @turn.team.players[0].big_gravatar)
        @names << subview(UILabel, :player_name, :text => @turn.team.players[0].name)
        @hit_buttons << subview(UIButton.custom, :hit_button)
        @miss_buttons << subview(UIButton.custom, :miss_button)
        @hit_cup_labels << subview(UILabel, :hit_cup_label)
      end
      @panels << subview(UIView, :two_of_three) do
        subview(UIImageView, :player_image, :image => @turn.team.players[1].big_gravatar)
        @names << subview(UILabel, :player_name, :text => @turn.team.players[1].name)
        @hit_buttons << subview(UIButton.custom, :hit_button)
        @miss_buttons << subview(UIButton.custom, :miss_button)
        @hit_cup_labels << subview(UILabel, :hit_cup_label)
      end
      @panels << subview(UIView, :three_of_three) do
        subview(UIImageView, :player_image, :image => @turn.team.players[2].big_gravatar)
        @names << subview(UILabel, :player_name, :text => @turn.team.players[2].name)
        @hit_buttons << subview(UIButton.custom, :hit_button)
        @miss_buttons << subview(UIButton.custom, :miss_button)
        @hit_cup_labels << subview(UILabel, :hit_cup_label)
      end
    else
      @panels << subview(UIView, :one_of_two) do
        subview(UIImageView, :player_image, :image => @turn.team.players[0].big_gravatar)
        @names << subview(UILabel, :player_name, :text => @turn.team.players[0].name)
        @hit_buttons << subview(UIButton.custom, :hit_button)
        @miss_buttons << subview(UIButton.custom, :miss_button)
        @hit_cup_labels << subview(UILabel, :hit_cup_label)
      end
      @panels << subview(UIView, :two_of_two) do
        subview(UIImageView, :player_image, :image => @turn.team.players[1].big_gravatar)
        @names << subview(UILabel, :player_name, :text => @turn.team.players[1].name)
        @hit_buttons << subview(UIButton.custom, :hit_button)
        @miss_buttons << subview(UIButton.custom, :miss_button)
        @hit_cup_labels << subview(UILabel, :hit_cup_label)
      end
    end
  end

  def layoutDidLoad
    @hit_buttons.each_with_index do |button, index|
      button.setTitle('Hit', forState:UIControlStateNormal)
      button.setTitleColor(:white.uicolor, forState:UIControlStateNormal)
    end
    @miss_buttons.each do |button|
      button.setTitle('Miss', forState:UIControlStateNormal)
      button.setTitleColor(:white.uicolor, forState:UIControlStateNormal)
    end
  end
end
