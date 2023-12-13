module External
  module StudentUsers
    class OmniauthCallbacksController < Devise::OmniauthCallbacksController
      def google_oauth2
        @student_user = StudentUser.from_omniauth(request.env['omniauth.auth'])

        if @student_user.persisted?
          flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
          sign_in_and_redirect @student_user, event: :authentication
        else
          session['devise.google_data'] = request.env['omniauth.auth'].except('extra')
          redirect_to new_user_registration_url, alert: @student_user.errors.full_messages.join("\n")
        end
      end
    end
  end
end
