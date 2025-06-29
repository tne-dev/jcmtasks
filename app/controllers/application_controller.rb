class ApplicationController < ActionController::Base
  include Pagy::Backend

  # Setup controller before used
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, unless: :devise_controller?
  before_action :set_locale

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  around_action :switch_locale

  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end


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

  private

  def set_locale
    I18n.locale = params[:locale] || extract_locale_from_accept_language_header || I18n.default_locale
  end

  def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE']&.scan(/^[a-z]{2}/)&.find { |lang| I18n.available_locales.include?(lang.to_sym) }
  end

  def default_url_options
    { locale: I18n.locale }
  end
end
