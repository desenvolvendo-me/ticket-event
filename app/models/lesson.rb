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
class Lesson < ApplicationRecord
  belongs_to :event
  validates :link, :title, :description, presence: true
  has_one :quiz, dependent: :destroy
  has_one_attached :thumbnail

  before_create :before_create

  def before_create
    valid = Lessons::Validator.new(self).call

    if valid.present?
      errors.add(:event, valid)
    end
  end

  def calculate_quiz_results(student_responses, ticket)
    @student_responses = student_responses
    @ticket = ticket
    Quizzes::QuizResultCalculator.new(self, @student_responses, @ticket).calculate
  end
end
