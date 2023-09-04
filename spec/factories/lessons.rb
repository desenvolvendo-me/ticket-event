FactoryBot.define do
  factory :lesson do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    link { 'https://www.youtube.com/watch?v=your-video-id' }
    event
  end
end