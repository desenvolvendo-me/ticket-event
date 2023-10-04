# == Schema Information
#
# Table name: quiz_questions
#
#  id             :bigint           not null, primary key
#  answer1        :string
#  answer2        :string
#  answer3        :string
#  answer4        :string
#  correct_answer :integer
#  description    :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  quiz_id        :bigint           not null
#
# Indexes
#
#  index_quiz_questions_on_quiz_id  (quiz_id)
#
# Foreign Keys
#
#  fk_rails_...  (quiz_id => quizzes.id)
#
FactoryBot.define do
  factory :quiz_question do
    description { Faker::Lorem.sentence }
    answer1 { Faker::Lorem.word }
    answer2 { Faker::Lorem.word }
    answer3 { Faker::Lorem.word }
    answer4 { Faker::Lorem.word }
    correct_answer { rand(1..4) }
    association :quiz
  end
end
