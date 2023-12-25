module GradesDraws
  class Scoredraw
    def initialize(event, lesson, student_responses, ticket)
      @event = event
      @lesson = lesson
      @student_responses = student_responses
      @ticket = ticket
    end

    def integrate
      calculate_quiz_result
      generate_prize_draw if eligible_for_prize_draw?
    end

    private

    def calculate_quiz_result #Chama o metodo que calcula as questoes corretas
      Quizzes::QuizResultCalculator.new(@lesson, @student_responses, @ticket).calculate
    end

    def eligible_for_prize_draw? # Confirma se a nota está igual ou acima do PASSING_SCORE
      @ticket.student_score.to_f >= PrizeDraws::Generator::PASSING_SCORE
    end

    def generate_prize_draw #Cria um novo sorteio vinculando o ticket do aluno
      PrizeDraws::Generator.new(@event).call
    end
  end
end
