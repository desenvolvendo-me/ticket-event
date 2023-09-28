module Quizzes
  class QuizResultCalculator
    def initialize(lesson, student_responses, ticket)
      @lesson = lesson
      @student_responses = student_responses
      @ticket = ticket
    end

    def calculate
      if @ticket
        quiz = @lesson.quiz
        quiz_questions = quiz.quiz_questions
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

        if @ticket.student_score == nil
          @ticket.student_score = {}
        end
        @ticket.student_score[quiz.id.to_s] = total_hits.to_i
        @ticket.save

        {
          correct_responses: correct_responses,
          incorrect_responses: incorrect_responses
        }
      else
      end
    end
  end
end
