class ApplicationController < ActionController::Base
  include ActiveStorage::SetCurrent
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :avatar, :full_name, :login, :password, :password_confirmation, student_attributes: [:name, :email, :phone, :type_social, :profile_social]])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :login, :password])
    devise_parameter_sanitizer.permit(:account_update, keys: [:login, :full_name, :email, :password, :password_confirmation, :current_password, :avatar])
  end
end
