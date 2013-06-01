Teacup::Stylesheet.new(:players_sheet) do
  import :mlp

  style :cell,
    background: BackgroundColor

  style :player_card, extends: :field_box,
    constraints: [
      constrain(:width).equals(:superview, :width).times(0.9),
      constrain(:height).equals(:superview, :height).times(0.8),
      constrain(:center_x).equals(:superview, :center_x),
      constrain(:center_y).equals(:superview, :center_y),
    ]

  style :player_image,
    layer: {
      masksToBounds: true,
      cornerRadius: 30,
    },
    constraints: [
      constrain_width(60),
      constrain_height(60),
      constrain(:center_y).equals(:superview, :center_y),
      constrain(:left).equals(:superview, :left).plus(10),
    ]

  style :player_name,
    font: :bold.uifont(18),
    backgroundColor: :clear.uicolor,
    textAlignment: :center.uialignment,
    constraints: [
      constrain(:top).equals(:superview, :top).plus(5),
      constrain(:right).equals(:superview, :right).minus(5),
      constrain(:left).equals(:superview, :left).plus(80),
    ]

  style :player_team,
    color: TrimColor,
    backgroundColor: :clear.uicolor,
    font: 'HelveticaNeue'.uifont(12),
    textAlignment: :center.uialignment,
    constraints: [
      constrain_below(:player_name),
      constrain(:right).equals(:superview, :right).minus(5),
      constrain(:left).equals(:superview, :left).plus(80),
    ]

  style :player_hit_percentage,
    color: TrimColor,
    backgroundColor: :clear.uicolor,
    font: 'HelveticaNeue'.uifont(12),
    textAlignment: :center.uialignment,
    constraints: [
      constrain_below(:player_team),
      constrain(:right).equals(:superview, :right).minus(5),
      constrain(:left).equals(:superview, :left).plus(80),
    ]

  style :player_point_percentage,
    color: TrimColor,
    backgroundColor: :clear.uicolor,
    font: 'HelveticaNeue'.uifont(12),
    textAlignment: :center.uialignment,
    constraints: [
      constrain_below(:player_hit_percentage),
      constrain(:right).equals(:superview, :right).minus(5),
      constrain(:left).equals(:superview, :left).plus(80),
    ]
end
