class CreateSeasonScreen < Formotion::FormController

  def build_form
    @form = Formotion::Form.new({
      sections: [{
        title: 'Season',
        rows: [{
          title: 'Name',
          placeholder: 'Name',
          type: :string,
          key: :name
        }]
      },{
        rows: [{
          title: 'Create Season',
          type: :submit
        }]
      }]
    })
  end
end
