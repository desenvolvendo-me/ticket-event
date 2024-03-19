# == Schema Information
#
# Table name: certificates
#
#  id                :bigint           not null, primary key
#  verification_link :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  event_id          :bigint           not null
#  student_id        :bigint           not null
#
# Indexes
#
#  index_certificates_on_event_id    (event_id)
#  index_certificates_on_student_id  (student_id)
#
# Foreign Keys
#
#  fk_rails_...  (event_id => events.id)
#  fk_rails_...  (student_id => students.id)
#
require 'rails_helper'

RSpec.describe Certificate, type: :model do
  it 'generates verification link before create' do
    certificate = create(:certificate)

    expect(certificate.verification_link).to be_present
  end
end
