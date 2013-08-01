HeaderHeight = 130
GravatarSize = 40

Teacup::Stylesheet.new(:game_overview_sheet) do
  style :root,
    backgroundColor: :white

  style :rounds_table,
    backgroundColor: :white,
    separatorStyle: UITableViewCellSeparatorStyleNone,
    constraints: [
      constrain_below(:header),
      constrain(:center_x).equals(:superview, :center_x),
      constrain(:width).equals(:superview, :width),
      constrain(:height).equals(:superview, :height).minus(HeaderHeight),
    ]

  style :round_number,
    textColor: BlueColor,
    font: :bold.uifont(10),
    backgroundColor: :clear,
    constraints: [
      constrain(:center_x).equals(:superview, :center_x),
      constrain(:center_y).equals(:superview, :center_y),
    ]

  style :round_number_label,
    text: 'Round',
    textColor: BlueColor,
    font: :bold.uifont(10),
    backgroundColor: :clear,
    constraints: [
      constrain(:center_x).equals(:superview, :center_x),
      constrain(:bottom).equals(:superview, :bottom).plus(5),
    ]


  style :header,
    constraints: [
      constrain_height(HeaderHeight),
      constrain(:left).equals(:superview, :left),
      constrain(:right).equals(:superview, :right),
      constrain(:top).equals(:superview, :top),
    ],
    border: { bottom: {
        width: 10,
        color: :black.uicolor,
    }}

  style :gravatar,
    layer: {
      cornerRadius: GravatarSize/2,
      masksToBounds: true,
    }

  style :name,
    numberOfLines: 2,
    textAlignment: :center,
    font: :bold.uifont(12),
    backgroundColor: :clear

  style :team_name,
    textAlignment: :center,
    font: :bold.uifont(16),
    backgroundColor: :clear

  style :home_team_name, extends: :team_name,
    constraints: [
      constrain_above(:home_team_p2_icon, 13),
      constrain(:center_x).equals(:home_team_p2_icon, :center_x),
    ]

  style :away_team_name, extends: :team_name,
    constraints: [
      constrain_above(:away_team_p2_icon, 13),
      constrain(:center_x).equals(:away_team_p2_icon, :center_x),
    ]

  style :cup_number,
    backgroundColor: :clear,
    font: :bold.uifont(14)

  (1..3).each do |pos|
    style :"home_team_p#{pos}_icon", extends: :gravatar,
      constraints: [
        constrain_width(GravatarSize),
        constrain_height(GravatarSize),
        constrain(:center_x).equals(:superview, :center_x).minus(47 + (94 * (pos-1))),
        constrain(:center_y).equals(:superview, :center_y),
      ]

    style :"away_team_p#{pos}_icon", extends: :gravatar,
      constraints: [
        constrain_width(GravatarSize),
        constrain_height(GravatarSize),
        constrain(:center_x).equals(:superview, :center_x).plus(47 + (94 * (pos-1))),
        constrain(:center_y).equals(:superview, :center_y),
      ]

    style :"home_team_p#{pos}_name", extends: :name,
      constraints: [
        constrain_below(:"away_team_p#{pos}_icon", 5),
        constrain(:center_x).equals(:"home_team_p#{pos}_icon", :center_x),
      ]

    style :"away_team_p#{pos}_name", extends: :name,
      constraints: [
        constrain_below(:"away_team_p#{pos}_icon", 5),
        constrain(:center_x).equals(:"away_team_p#{pos}_icon", :center_x),
      ]

    style :"home_p#{pos}_score", extends: :cup_number,
      constraints: [
        constrain(:center_y).equals(:superview, :center_y),
        constrain(:center_x).equals(:superview, :right).minus(47 + (94 * (pos-1))),
      ]

    style :"away_p#{pos}_score", extends: :cup_number,
      constraints: [
        constrain(:center_y).equals(:superview, :center_y),
        constrain(:center_x).equals(:superview, :left).plus(47 + (94 * (pos-1))),
      ]
  end

  style :home_shots_panel,
    constraints: [
      constrain(:height).equals(:superview, :height),
      constrain(:width).equals(:superview, :width).times(0.5),
      constrain(:left).equals(:superview, :left),
      constrain(:top).equals(:superview, :top),
    ]

  style :away_shots_panel,
    constraints: [
      constrain(:height).equals(:superview, :height),
      constrain(:width).equals(:superview, :width).times(0.5),
      constrain(:right).equals(:superview, :right),
      constrain(:top).equals(:superview, :top),
    ]
end
