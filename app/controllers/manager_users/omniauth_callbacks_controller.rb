# frozen_string_literal: true

class ManagerUsers::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  def google_oauth2
    manager_user = ManagerUser.from_omniauth(auth)

    if manager_user.present?
      sign_out_all_scopes
      flash[:success] = t 'devise.omniauth_callbacks.success' , kind: 'Google'
      sign_in_and_redirect manager_user, event: :authentication
    else
      flash[:error] = t 'devise.omniauth_callbacks.failure', kind: 'Google', reason: 'User not found'
      redirect_to new_manager_user_session_path
    end
  end
  # More info at:
  # https://github.com/heartcombo/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
  private
  def auth
    @auth ||= request.env['omniauth.auth']
  end
end
