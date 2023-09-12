# == Schema Information
#
# Table name: quizzes
#
#  id         :bigint           not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  lesson_id  :bigint           not null
#
# Indexes
#
#  index_quizzes_on_lesson_id  (lesson_id)
#
# Foreign Keys
#
#  fk_rails_...  (lesson_id => lessons.id)
#
class Quiz < ApplicationRecord
  belongs_to :lesson
  has_many :quiz_question, dependent: :destroy
  accepts_nested_attributes_for :quiz_question, allow_destroy: true
end
