class QuizController < ExternalController
  before_action :get_ticket, only: %i[ submit result ]
  def show
    @lesson = Lesson.find(params[:lesson_id])
    @quiz = @lesson.quiz
    @quiz_questions = @quiz.quiz_questions
  end

  def submit
    @lesson = Lesson.find(params[:lesson_id])
    @quiz = @lesson.quiz
    @quiz_questions = @quiz.quiz_questions
    @student_responses = params[:responses]

    @ticket.student_score ||= {}
    @correct_responses = {}
    @incorrect_responses = {}
    correct_quantity = 0
    wrong_quantity = 0

    @quiz_questions.each do |question|
      correct_answer = question.correct_answer
      student_answer = @student_responses[question.id.to_s].sub("answer", "").to_i

      if student_answer == correct_answer
        @correct_responses[question.id] = student_answer
        correct_quantity += 1
      else
        wrong_quantity += 1
        @incorrect_responses[question.id] = {
          student_answer: student_answer,
          correct_answer: correct_answer,
        }
      end
    end
    total_hits = (correct_quantity.to_f / @quiz_questions.all.count.to_f) * 100

    @ticket.student_score[@quiz.id.to_s] = total_hits.to_i
    @ticket.save
    redirect_to quiz_result_path(correct_responses: @correct_responses, incorrect_responses: @incorrect_responses)
  end


  def result
    @lesson = Lesson.find(params[:lesson_id])
    @quiz = @lesson.quiz
    @quiz_questions = @quiz.quiz_questions
    @correct_responses = params[:correct_responses]
    @incorrect_responses = params[:incorrect_responses]
    if @ticket.student_score[@quiz.id.to_s] >= 70
      flash[:notice] = "Parabéns, você atingiu a pontuação e está apto à proxima fase"
    else
      flash[:alert] = "A pontuação mínima necessária é de 70%"
      end
  end

  def get_ticket
    @ticket = Ticket.joins(:event, :student)
                    .where(events: { slug: params["slug_event"] }, students: { phone: session[:student_phone] }).take
  end
end
