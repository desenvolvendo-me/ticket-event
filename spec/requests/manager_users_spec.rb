# spec/requests/manager_users_spec.rb
require 'rails_helper'

RSpec.describe 'ManagerUsers', type: :request do
  describe 'POST /users' do
    context 'with valid parameters' do
      let(:valid_params) do
        { manager_user: { email: 'test@example.com', password: 'password', password_confirmation: 'password' } }
      end

      it 'creates a new user' do
        expect {
          post manager_user_registration_path, params: valid_params
        }.to change(ManagerUser, :count)
      end



      it 'redirects to the home page after sign up' do
        post manager_user_registration_path, params: valid_params
        expect(response).to redirect_to(root_path)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) do
        { user: { email: '', password: 'password', password_confirmation: 'password' } }
      end

      it 'does not create a new user' do
        expect {
          post manager_user_registration_path, params: invalid_params
        }.not_to change(ManagerUser, :count)
      end
    end
  end
end
