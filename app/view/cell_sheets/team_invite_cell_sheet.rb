Teacup::Stylesheet.new(:team_invite_cell_sheet) do
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
    font: 'HelveticaNeue'.uifont(12),
    textAlignment: :center.uialignment

  style :player1_name, extends: :player_name,
    constraints: [
      constrain_below(:team_name),
      constrain(:center_x).equals(:superview, :center_x),
    ]

  style :player2_name, extends: :player_name,
    constraints: [
      constrain_below(:player1_name),
      constrain(:center_x).equals(:superview, :center_x),
    ]

  style :player3_name, extends: :player_name,
    constraints: [
      constrain_below(:player2_name),
      constrain(:center_x).equals(:superview, :center_x),
    ]

  style :status,
    color: TrimColor,
    backgroundColor: :clear.uicolor,
    font: :bold.uifont(14),
    textAlignment: :right.uialignment

  style :incomplete, extends: :status,
    text: 'Incomplete',
    constraints: [
      constrain(:right).equals(:superview, :right).minus(2),
      constrain(:bottom).equals(:superview, :bottom).minus(2),
    ]

  style :accepted, extends: :status,
    text: 'Accepted',
    color: BlueColor,
    constraints: [
      constrain(:right).equals(:superview, :right).minus(2),
      constrain(:bottom).equals(:superview, :bottom).minus(2),
    ]

  style :rejected, extends: :status,
    text: 'Rejected',
    color: RedColor,
    constraints: [
      constrain(:right).equals(:superview, :right).minus(2),
      constrain(:bottom).equals(:superview, :bottom).minus(2),
    ]
end
