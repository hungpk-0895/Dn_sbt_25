class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  before_action :config_permitted_parameters, if: :devise_controller?
  before_action :set_locale
  before_action :store_user_location!, if: :storable_location?

  rescue_from CanCan::AccessDenied do
    if user_signed_in?
      flash[:danger] = t "check.no_permission"
      redirect_to root_path
    else
      flash[:danger] = t "check.require_login"
      redirect_to new_user_session_url
    end
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  private
  def admin_user
    if current_user.nil?
      flash[:danger] = t "check.require_login"
      redirect_to new_user_session_url
    else
      return if current_user.admin?
      flash[:danger] = t "check.no_permission"
      redirect_to root_path
    end
  end

  def config_permitted_parameters
    added_attrs = [:name, :phone, :email, :password, :password_confirmation]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  def storable_location?
    location = request.get? && is_navigational_format?
    location && !devise_controller? && !request.xhr?
  end

  def store_user_location!
    # :user is the scope we are authenticating
    store_location_for(:user, request.fullpath)
  end
end
