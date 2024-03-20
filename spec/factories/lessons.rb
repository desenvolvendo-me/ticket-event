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
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    link { 'https://www.youtube.com/watch?v=your-video-id' }
    launch_datetime { Time.now + 5.hours }
    event

    after(:create) do |lesson, evaluator|
      create(:student_lesson, lesson: lesson, status: 'not started')
    end
  end
end
