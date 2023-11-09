RSpec.configure do |config|
  config.before(:each, type: :controller) do
    @request.env["devise.mapping"] = Devise.mappings[:manager_user]
    manager_user = FactoryBot.create(:manager_user)
    sign_in manager_user
  end

  config.before(:each, type: :feature) do
    manager_user = FactoryBot.create(:manager_user)
    sign_in manager_user
  end

  config.before(:each, type: :request) do
    manager_user = FactoryBot.create(:manager_user)
    sign_in manager_user
  end
end
