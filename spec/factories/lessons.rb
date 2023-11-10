# == Schema Information
#
# Table name: lessons
#
#  id              :bigint           not null, primary key
#  description     :text
#  launch_datetime :datetime
#  link            :string
#  thumbnail       :string
#  title           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  event_id        :bigint           not null
#  manager_user_id :bigint           not null
#
# Indexes
#
#  index_lessons_on_event_id         (event_id)
#  index_lessons_on_manager_user_id  (manager_user_id)
#
# Foreign Keys
#
#  fk_rails_...  (event_id => events.id)
#  fk_rails_...  (manager_user_id => manager_users.id)
#
FactoryBot.define do
  factory :lesson do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    link { 'https://www.youtube.com/watch?v=your-video-id' }
    launch_datetime { Time.now + 5.hours }
    event
    association :manager_user_id
  end
end
