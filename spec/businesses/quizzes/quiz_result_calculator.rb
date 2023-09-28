require 'rails_helper'

RSpec.describe Quizzes::QuizResultCalculator do
  describe '.calculate' do
    it 'passed' do
      #DADO
      answer = {
        lesson_id: @lesson.id,
        params: params
      }
      ticket = create(:ticket, answer: answer)

      #QUANDO
      Quizzes::QuizResultCalculator.new(ticket).calculate

      #ENTÃO
      expect(ticket.student_score).to eq(70)
    end

    it 'not passed' do
      #DADO
      answer = {
        lesson_id: @lesson.id,
        params: params
      }
      ticket = create(:ticket, answer: answer)

      #QUANDO
      Quizzes::QuizResultCalculator.new(ticket).calculate

      #ENTÃO
      expect(ticket.student_score).to eq(50)
    end
  end
end
