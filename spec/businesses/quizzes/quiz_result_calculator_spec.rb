require 'rails_helper'

RSpec.describe Quizzes::QuizResultCalculator do
  describe '.calculate' do
    it 'passed' do
      #DADO
      parameters = {"1"=>"answer1", "2"=>"answer1", "3"=>"answer1", "4"=>"answer1", "5"=>"answer1",
                    "6"=>"answer1", "7"=>"answer1", "8"=>"answer3", "9"=>"answer4", "10"=>"answer2"}

      student = create(:student, phone: '2196604')
      event = create(:event)
      ticket = create(:ticket, student: student, event: event)
      lesson = create(:lesson, event: event)
      quiz = create(:quiz, lesson: lesson)
      create(:quiz_question, correct_answer: 1, quiz: quiz)
      create(:quiz_question, correct_answer: 1, quiz: quiz)
      create(:quiz_question, correct_answer: 1, quiz: quiz)
      create(:quiz_question, correct_answer: 1, quiz: quiz)
      create(:quiz_question, correct_answer: 1, quiz: quiz)
      create(:quiz_question, correct_answer: 1, quiz: quiz)
      create(:quiz_question, correct_answer: 1, quiz: quiz)
      create(:quiz_question, correct_answer: 1, quiz: quiz)
      create(:quiz_question, correct_answer: 1, quiz: quiz)
      create(:quiz_question, correct_answer: 1, quiz: quiz)

      #QUANDO
      Quizzes::QuizResultCalculator.new(lesson, parameters, ticket).calculate

      #ENTÃO
      expect(ticket.student_score).to eq(70)
    end

    it 'not passed' do
      #DADO
      parameters = {"1"=>"answer3", "2"=>"answer3", "3"=>"answer1", "4"=>"answer4"}

      student = create(:student, phone: '2196604')
      event = create(:event)
      ticket = create(:ticket, student: student, event: event)
      lesson = create(:lesson, event: event)
      quiz = create(:quiz, lesson: lesson)
      create(:quiz_question, correct_answer: 3, quiz: quiz)
      create(:quiz_question, correct_answer: 3, quiz: quiz)
      create(:quiz_question, correct_answer: 2, quiz: quiz)
      create(:quiz_question, correct_answer: 1, quiz: quiz)

      #QUANDO
      Quizzes::QuizResultCalculator.new(lesson, parameters, ticket).calculate

      #ENTÃO
      expect(ticket.student_score).to eq(50)
    end
  end
end
