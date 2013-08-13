Teacup::Stylesheet.new(:player_details_sheet) do
  style :root,
    backgroundColor: BackgroundColor

  style :gravatar,
    layer: {
      masksToBounds: true,
      cornerRadius: 30,
    },
    constraints: [
      constrain_width(60),
      constrain_height(60),
      # constrain(:left).equals(:superview, :left).plus(50),
      constrain(:center_x).equals(:superview, :center_x),
      constrain(:top).equals(:superview, :top).plus(50),
    ]

  style :important_stats_box,
    backgroundColor: :white,
    layer: {
      cornerRadius: 2,
    },
    constraints: [
      constrain_width(280),
      constrain_height(120),
      constrain(:center_x).equals(:superview, :center_x),
      constrain_below(:gravatar, 20),
    ]

  style :stat_label,
    textAlignment: :left.uialignment,
    text: 'Season Point Percentage',
    font: :bold.uifont(13),
    textColor: :black,
    backgroundColor: :clear

  style :stat,
    textAlignment: :right.uialignment,
    font: :bold.uifont(18),
    textColor: :black,
    backgroundColor: :clear

  style :spp_label, extends: :stat_label,
    constraints: [
      constrain(:left).equals(:superview, :left).plus(10),
      constrain(:center_y).equals(:spp, :center_y),
    ]

  style :spp, extends: :stat,
    constraints: [
      constrain(:right).equals(:superview, :right).minus(10),
      constrain_above(:shp, 10),
    ]

  style :shp_label, extends: :stat_label,
    text: 'Season Hit Percentage',
    constraints: [
      constrain(:left).equals(:superview, :left).plus(10),
      constrain(:center_y).equals(:shp, :center_y),
    ]

  style :shp, extends: :stat,
    constraints: [
      constrain(:right).equals(:superview, :right).minus(10),
      constrain(:center_y).equals(:superview, :center_y),
    ]

  style :slc_label, extends: :stat_label,
    text: 'Season Last Cups',
    constraints: [
      constrain(:left).equals(:superview, :left).plus(10),
      constrain(:center_y).equals(:slc, :center_y),
    ]

  style :slc, extends: :stat,
    constraints: [
      constrain(:right).equals(:superview, :right).minus(10),
      constrain_below(:shp, 10),
    ]

  style :lpp_label, extends: :stat_label,
    text: 'League Point Percentage',
    constraints: [
      constrain(:left).equals(:superview, :left).plus(10),
      constrain(:center_y).equals(:lpp, :center_y),
    ]

  style :lpp, extends: :stat,
    constraints: [
      constrain(:right).equals(:superview, :right).minus(10),
      constrain_below(:important_stats_box, 25),
    ]

  style :lhp_label, extends: :stat_label,
    text: 'League Hit Percentage',
    constraints: [
      constrain(:left).equals(:superview, :left).plus(10),
      constrain(:center_y).equals(:lhp, :center_y),
    ]

  style :lhp, extends: :stat,
    constraints: [
      constrain(:right).equals(:superview, :right).minus(10),
      constrain_below(:lpp, 10),
    ]

  style :llc_label, extends: :stat_label,
    text: 'League Last Cups',
    constraints: [
      constrain(:left).equals(:superview, :left).plus(10),
      constrain(:center_y).equals(:llc, :center_y),
    ]

  style :llc, extends: :stat,
    constraints: [
      constrain(:right).equals(:superview, :right).minus(10),
      constrain_below(:lhp, 10),
    ]
end
