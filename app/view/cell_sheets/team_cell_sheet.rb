Teacup::Stylesheet.new(:team_cell_sheet) do
  import :mlp

  style :cell,
    background: BackgroundColor

  style :team_card, extends: :field_box,
    constraints: [
      constrain(:width).equals(:superview, :width).times(0.9),
      constrain(:height).equals(:superview, :height).times(0.8),
      constrain(:center_x).equals(:superview, :center_x),
      constrain(:center_y).equals(:superview, :center_y),
    ]

  style :team_name,
    font: :bold.uifont(18),
    backgroundColor: :clear.uicolor,
    textAlignment: :center.uialignment,
    constraints: [
      constrain(:top).equals(:superview, :top).plus(5),
      constrain(:center_x).equals(:superview, :center_x),
    ]

  style :player_name,
    color: TrimColor,
    backgroundColor: :clear.uicolor,
    font: 'HelveticaNeue'.uifont(14),
    textAlignment: :center.uialignment

  style :player1_name, extends: :player_name,
    constraints: [
      constrain(:bottom).equals(:superview, :bottom).minus(2),
      constrain(:left).equals(:superview, :left).plus(5),
    ]

  style :player2_name, extends: :player_name,
    constraints: [
      constrain_above(:player1_name),
      constrain(:left).equals(:superview, :left).plus(5),
    ]

  style :player3_name, extends: :player_name,
    constraints: [
      constrain_above(:player2_name),
      constrain(:left).equals(:superview, :left).plus(5),
    ]

  style :team_stat,
    font: :bold.uifont(16),
    backgroundColor: :clear.uicolor,
    textAlignment: :center.uialignment

  style :wins_label, extends: :team_stat,
    color: RedColor,
    constraints: [
      constrain_above(:losses_label),
      constrain(:right).equals(:superview, :right).minus(5),
    ]

  style :losses_label, extends: :team_stat,
    color: BlueColor,
    constraints: [
      constrain(:bottom).equals(:superview, :bottom).minus(5),
      constrain(:right).equals(:superview, :right).minus(5),
    ]
end
