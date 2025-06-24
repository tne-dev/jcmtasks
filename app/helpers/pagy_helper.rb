module PagyHelper
  include Pagy::Frontend

  def pagy_bootstrap_nav(pagy)
    super(pagy).html_safe
  end
end
