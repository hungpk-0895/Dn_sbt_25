class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  before_action :config_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  def default_url_options
    {locale: I18n.locale}
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  private
  def admin_user
    return if current_user.admin?
    flash[:danger] = t ".not_have_permission"
    redirect_to root_path
  end

  def config_permitted_parameters
    added_attrs = [:name, :phone, :email, :password, :password_confirmation]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
