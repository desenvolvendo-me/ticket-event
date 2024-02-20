require 'rails_helper'

RSpec.describe Certificate, type: :model do
  it 'generates verification link before create' do
    certificate = create(:certificate)

    expect(certificate.verification_link).to be_present
  end
end
