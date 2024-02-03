require 'rails_helper'

RSpec.describe External::CertificatesController, type: :controller do
  describe 'GET #verify' do
    it 'renders verify template for valid certificate' do
      certificate = create(:certificate)
      get :verify, params: { verification_link: certificate.verification_link }
      expect(response).to have_http_status(:success)
    end

    it 'renders not_found template for invalid certificate' do
      get :verify, params: { verification_link: 'invalid_link' }
      expect(response).to have_http_status(:not_found)
      expect(response).to render_template('external/certificates/not_found')
    end
  end
end
