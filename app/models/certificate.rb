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
class Certificate < ApplicationRecord
  belongs_to :event
  belongs_to :student

  has_one_attached :png
  has_one_attached :svg

  # TODO: remove to seed
  # before_create :generate_verification_link
  # def generate_verification_link
  #   self.verification_link = SecureRandom.hex
  # end
  #
  # def absolute_url
  #   Rails.application.routes.url_helpers.verify_certificate_url(verification_link, host: ENV['BASE_URL'])
  # end

end
