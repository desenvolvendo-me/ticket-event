class External::QuizController < ExternalController
  before_action :load_lesson, only: %i[show submit result]
  before_action :load_ticket, only: %i[submit result]

  def show
    load_quiz_data
  end

  def submit
    Quizzes::QuizResultCalculator.new(@lesson, params[:responses], @ticket).calculate
    redirect_to quiz_result_path
  end

  def result
    load_quiz_data
    @student_answers = @ticket.student_answers["Quiz#{@lesson.quiz.id.to_s}"]
    @quiz_result = Quiz::percentage_success?(@ticket, @lesson)
    if @quiz_result
      flash[:notice] = I18n.t('controller.quiz.result.success')
    else
      flash[:alert] = I18n.t('controller.quiz.result.failure')
    end
  end

  private

  def load_lesson
    @lesson = Lesson.find(params[:lesson_id])
  end

  def load_ticket
    @ticket = Ticket.joins(:event, :student)
                    .where(events: { slug: params["slug_event"] }, students: { phone: session[:student_phone] }).take
  end

  def load_quiz_data
    @quiz = @lesson.quiz
    @quiz_questions = @quiz.quiz_questions
  end
end
