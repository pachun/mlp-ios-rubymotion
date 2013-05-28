class FormScreen < Formotion::FormController
  include ProMotion::ScreenModule

  def self.build(t, f)
    title(t)
    super(f)
  end
end
