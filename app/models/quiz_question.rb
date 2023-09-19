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
class QuizQuestion < ApplicationRecord
  belongs_to :quiz
  validates :correct_answer, inclusion: { in: 1..4 }
end
