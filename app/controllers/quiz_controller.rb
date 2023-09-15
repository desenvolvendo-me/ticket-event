class QuizController < ExternalController
  def show
    @lesson = Lesson.find(params[:lesson_id])
    @quiz = @lesson.quiz
    @quiz_questions = @quiz.quiz_questions
  end

  def submit
  end

  private

end
