class ApplicationController < ActionController::Base
  include ActiveStorage::SetCurrent
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_manager_user!, except: [:verify]

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :avatar, :full_name, :login, :password, :password_confirmation])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :login, :password])
    devise_parameter_sanitizer.permit(:account_update, keys: [:login, :full_name, :email, :password, :password_confirmation, :current_password, :avatar])
  end
end
