require 'rails_helper'

RSpec.describe Quizzes::QuizResultCalculator do
  describe '.calculate' do
    before(:each) do
      DatabaseCleaner.start
    end

    after(:each) do
      DatabaseCleaner.clean
    end
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
      expect(ticket.student_answers["Quiz#{quiz.id}"]["percentage_hits"]).to eq(70)
    end

    it 'not passed' do
      #DADO
      parameters = {"11"=>"answer3", "12"=>"answer3", "13"=>"answer1", "14"=>"answer4"}

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
      expect(ticket.student_answers["Quiz#{quiz.id}"]["percentage_hits"]).to eq(50)
    end

    it 'partially passed' do
      # DADO
      parameters = {"15"=>"answer1", "16"=>"answer2", "17"=>"answer3"}

      student = create(:student, phone: '2196604')
      event = create(:event)
      ticket = create(:ticket, student: student, event: event)
      lesson = create(:lesson, event: event)
      quiz = create(:quiz, lesson: lesson)
      create(:quiz_question, correct_answer: 1, quiz: quiz)
      create(:quiz_question, correct_answer: 2, quiz: quiz)
      create(:quiz_question, correct_answer: 1, quiz: quiz)

      # QUANDO
      Quizzes::QuizResultCalculator.new(lesson, parameters, ticket).calculate

      # ENTÃO
      expect(ticket.student_answers["Quiz#{quiz.id}"]["percentage_hits"]).to eq(66)
    end
  end
end
