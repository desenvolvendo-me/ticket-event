module Quizzes
  class QuizResultCalculator
    def initialize(lesson, student_responses, ticket)
      @lesson = lesson
      @student_responses = student_responses
      @ticket = ticket
    end

    def calculate
      quiz_questions = @lesson.quiz.quiz_questions
      correct_responses = {}
      incorrect_responses = {}
      correct_quantity = 0
      wrong_quantity = 0

      quiz_questions.each do |question|
        correct_answer = question.correct_answer
        student_answer = @student_responses[question.id.to_s].sub("answer", "").to_i

        if student_answer == correct_answer
          correct_responses[question.id] = student_answer
          correct_quantity += 1
        else
          wrong_quantity += 1
          incorrect_responses[question.id] = {
            student_answer: student_answer,
            correct_answer: correct_answer,
          }
        end
      end

      total_hits = (correct_quantity.to_f / quiz_questions.count.to_f) * 100

      @ticket.student_answers ||= {}
      @ticket.student_answers["Quiz#{@lesson.quiz.id.to_s}"] = {
        correct_responses: correct_responses,
        incorrect_responses: incorrect_responses,
        percentage_hits: total_hits.to_i
      }
      @ticket.student_score = @ticket.student_answers.values.select { |data| data["percentage_hits"] }.sum { |data| data["percentage_hits"] }.to_f / @ticket.student_answers.values.select { |data| data["percentage_hits"] }.length
      @ticket.save
      {
        correct_responses: correct_responses,
        incorrect_responses: incorrect_responses
      }
    end
  end
end
