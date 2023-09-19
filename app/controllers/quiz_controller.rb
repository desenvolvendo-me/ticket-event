class QuizController < ExternalController
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

    correct_responses = {}
    incorrect_responses = {}

    @quiz_questions.each do |question|
      correct_answer = question.correct_answer
      student_answer = @student_responses[question.id.to_s].sub("answer", "").to_i

      if student_answer == correct_answer
        correct_responses[question.id] = student_answer
      else
        incorrect_responses[question.id] = {
          student_answer: student_answer,
          correct_answer: correct_answer,
        }
      end
    end

    redirect_to quiz_result_path(correct_responses: correct_responses, incorrect_responses: incorrect_responses)
  end


  def result
    @lesson = Lesson.find(params[:lesson_id])
    @quiz = @lesson.quiz
    @quiz_questions = @quiz.quiz_questions
    @correct_responses = params[:correct_responses]
    @incorrect_responses = params[:incorrect_responses]
  end
end
