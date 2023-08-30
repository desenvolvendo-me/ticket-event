# == Schema Information
#
# Table name: lessons
#
#  id         :bigint           not null, primary key
#  link       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  event_id   :bigint           not null
#
# Indexes
#
#  index_lessons_on_event_id  (event_id)
#
# Foreign Keys
#
#  fk_rails_...  (event_id => events.id)
#
FactoryBot.define do
  factory :lesson do
    link { "https://youtu.be/_XUdbOFrDRQ?si=QQhY7FPlXInMKvTv" }
    event { nil }
  end
end
