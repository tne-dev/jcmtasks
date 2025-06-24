class ApplicationController < ActionController::Base
  # Setup controller before used
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, unless: :devise_controller?

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Use helpers
  helper PagyHelper


  protected

  # Allow added User params (Devise)
  def configure_permitted_parameters
    # list all your extra fields here
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :first_name, :last_name ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :first_name, :last_surname ])
  end

  # Change default sign in message
  def after_sign_in_path_for(resource)
    flash[:notice] = resource.welcome_msg
    super
  end
end
