class CreateLeagueScreen < Formotion::FormController

  def build_form
    @form = Formotion::Form.new({
      sections: [{
        rows: [{
          title: 'Name',
          placeholder: 'Name',
          type: :string,
          key: :name,
        }]
      },{
        title: 'Rules',
        rows: [{
          title: 'Players Per Team',
          placeholder: '2 or 3',
          type: :number,
          key: :players_per_team,
        },{
          title: 'Balls Back',
          value: false,
          type: :switch,
          key: :plays_balls_back,
        }]
      },{
        title: 'Optional',
        rows: [{
          title: 'Rerack Cups',
          type: :subform,
          key: :rerack_cups,
          subform: {
            title: 'Rerack Cups',
            sections: [{
              rows: [{
                title: 'Cup 1',
                type: :check,
                value: false,
                key: :cup_1,
              },{
                title: 'Cup 2',
                type: :check,
                value: false,
                key: :cup_2,
              },{
                title: 'Cup 3',
                type: :check,
                value: false,
                key: :cup_3,
              },{
                title: 'Cup 4',
                type: :check,
                value: false,
                key: :cup_4,
              },{
                title: 'Cup 5',
                type: :check,
                value: false,
                key: :cup_5,
              },{
                title: 'Cup 6',
                type: :check,
                value: false,
                key: :cup_6,
              },{
                title: 'Cup 7',
                type: :check,
                value: false,
                key: :cup_7,
              },{
                title: 'Cup 8',
                type: :check,
                value: false,
                key: :cup_8,
              },{
                title: 'Cup 9',
                type: :check,
                value: false,
                key: :cup_9,
              },{
                title: 'Cup 10',
                type: :check,
                value: false,
                key: :cup_10,
              }]
            }]
          }
        },{
          title: 'Extra Point Cups',
          type: :subform,
          key: :extra_point_cups,
          subform: {
            title: 'Extra Point Cups',
            sections: [{
              rows: [{
                title: 'Cup 1',
                type: :check,
                value: false,
                key: :cup_1,
              },{
                title: 'Cup 2',
                type: :check,
                value: false,
                key: :cup_2,
              },{
                title: 'Cup 3',
                type: :check,
                value: false,
                key: :cup_3,
              },{
                title: 'Cup 4',
                type: :check,
                value: false,
                key: :cup_4,
              },{
                title: 'Cup 5',
                type: :check,
                value: false,
                key: :cup_5,
              },{
                title: 'Cup 6',
                type: :check,
                value: false,
                key: :cup_6,
              },{
                title: 'Cup 7',
                type: :check,
                value: false,
                key: :cup_7,
              },{
                title: 'Cup 8',
                type: :check,
                value: false,
                key: :cup_8,
              },{
                title: 'Cup 9',
                type: :check,
                value: false,
                key: :cup_9,
              },{
                title: 'Cup 10',
                type: :check,
                value: false,
                key: :cup_10,
              }]
            }]
          }
        }]
      },{
        rows: [{
          title: 'Create League',
          type: :submit,
        }]
      }]
    })
  end
end
