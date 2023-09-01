# == Schema Information
#
# Table name: certificates
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  event_id   :bigint           not null
#  student_id :bigint           not null
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
FactoryBot.define do
  factory :certificate do
    student { nil }
  end
end
