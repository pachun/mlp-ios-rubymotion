Teacup::Stylesheet.new(:turn_screen_sheet) do
  style :root,
    backgroundColor: :white.uicolor

  IOS7_adjustment = 50
  style :one_of_three,
    constraints: [
      constrain(:top).equals(:superview, :top).plus(IOS7_adjustment),
      constrain(:left).equals(:superview, :left),
      constrain(:height).equals(:superview, :height),
      constrain(:width).equals(:superview, :width).times(0.33),
    ]

  style :two_of_three,
    constraints: [
      constrain(:top).equals(:superview, :top).plus(IOS7_adjustment),
      constrain(:left).equals(:one_of_three, :right),
      constrain(:height).equals(:superview, :height),
      constrain(:width).equals(:superview, :width).times(0.34),
    ]

  style :three_of_three,
    constraints: [
      constrain(:top).equals(:superview, :top).plus(IOS7_adjustment),
      constrain(:left).equals(:two_of_three, :right),
      constrain(:height).equals(:superview, :height),
      constrain(:width).equals(:superview, :width).times(0.33),
    ]

  style :one_of_two,
    constraints: [
      constrain(:top).equals(:superview, :top).plus(IOS7_adjustment),
      constrain(:left).equals(:superview, :left),
      constrain(:height).equals(:superview, :height),
      constrain(:width).equals(:superview, :width).times(0.5),
    ]

  style :two_of_two,
    constraints: [
      constrain(:top).equals(:superview, :top).plus(IOS7_adjustment),
      constrain(:right).equals(:superview, :right),
      constrain(:height).equals(:superview, :height),
      constrain(:width).equals(:superview, :width).times(0.5),
    ]

  style :player_image,
    layer: {
      cornerRadius: 60,
      masksToBounds: true,
    },
    constraints: [
      constrain_width(120),
      constrain_height(120),
      constrain(:center_x).equals(:superview, :center_x),
      constrain(:top).equals(:superview, :top).plus(10),
    ]

  style :player_name,
    font: :bold.uifont(18),
    backgroundColor: :clear.uicolor,
    constraints: [
      constrain_below(:player_image, 3),
      constrain(:center_x).equals(:superview, :center_x),
    ]

  style :hit_button,
    font: :bold.uifont,
    backgroundColor: RedColor,
    layer: { cornerRadius: 2 },
    constraints: [
      constrain_width(150),
      constrain_height(40),
      constrain_below(:player_name, 10),
      constrain(:center_x).equals(:superview, :center_x),
    ]

  style :miss_button,
    font: :bold.uifont,
    backgroundColor: BlueColor,
    layer: { cornerRadius: 2 },
    constraints: [
      constrain_width(150),
      constrain_height(40),
      constrain_below(:hit_button, 10),
      constrain(:center_x).equals(:superview, :center_x),
    ]

  style :hit_cup_label,
    text: '-',
    hidden: true,
    font: :bold.uifont(34),
    color: :white.uicolor,
    backgroundColor: :clear.uicolor,
    constraints: [
      constrain_height(40),
      constrain_below(:player_name, 10),
      constrain(:center_x).equals(:superview, :center_x),
    ]

  style :undo_button,
    font: :bold.uifont,
    backgroundColor: :white.uicolor,
    layer: { cornerRadius: 2 },
    constraints: [
      constrain_width(150),
      constrain_height(40),
      constrain_below(:player_name, 60),
      constrain(:center_x).equals(:superview, :center_x),
    ]
end
