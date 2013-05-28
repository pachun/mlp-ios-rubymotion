class FormScreen < Formotion::FormController
  include ProMotion::ScreenModule

  def initialize(title, form)
    navigationItem.title = title
    initWithForm(form)
  end
end
