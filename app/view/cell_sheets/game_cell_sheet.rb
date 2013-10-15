Teacup::Stylesheet.new(:game_cell_sheet) do
  import :mlp

  style :cell,
    background: BackgroundColor

  style :game_card, extends: :field_box,
    constraints: [
      constrain(:width).equals(:superview, :width).times(0.9),
      constrain(:height).equals(:superview, :height).times(0.8),
      constrain(:center_x).equals(:superview, :center_x),
      constrain(:center_y).equals(:superview, :center_y),
    ]

  style :game_time,
    font: :bold.uifont(12),
    backgroundColor: :clear.uicolor,
    textColor: BlueColor,
    constraints: [
      # constrain(:left).equals(:superview, :left).plus(5),
      # constrain(:top).equals(:superview, :top).plus(5),
      constrain(:right).equals(:superview, :right).minus(5),
      constrain(:center_y).equals(:superview, :center_y),
      constrain_width(60),
      constrain_height(10),
    ]

  style :team_name,
    font: :bold.uifont(18),
    backgroundColor: :clear.uicolor,
    textAlignment: :center.uialignment

  style :home_team_name, extends: :team_name,
    constraints: [
      constrain(:top).equals(:superview, :top).plus(5),
      constrain(:center_x).equals(:superview, :center_x),
    ]

  style :away_team_name, extends: :team_name,
    constraints: [
      constrain(:bottom).equals(:superview, :bottom).minus(5),
      constrain(:center_x).equals(:superview, :center_x),
    ]

  style :vs_label,
    text: 'vs',
    color: TrimColor,
    backgroundColor: :clear.uicolor,
    font: 'HelveticaNeue'.uifont(12),
    textAlignment: :center.uialignment,
    constraints: [
      constrain(:center_x).equals(:superview, :center_x),
      constrain(:center_y).equals(:superview, :center_y),
    ]
end
