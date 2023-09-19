ActiveAdmin.register Quiz do
  permit_params :title, :lesson_id, quiz_questions_attributes: [:id, :description, :answer1, :answer2, :answer3, :answer4, :correct_answer, :_destroy]

  show do
    attributes_table do
      row :lesson
      row :title
    end

    panel I18n.t('active_admin.quiz.questions.title') do
      table_for quiz.quiz_questions do
        column I18n.t('active_admin.quiz.questions.question_column') do |question|
          question.description
        end
        column I18n.t('active_admin.quiz.questions.answer_column') do |question|
          correct_answer_field = "answer#{question.correct_answer}"
          question[correct_answer_field]
        end
      end
    end
  end

  form do |f|
    f.inputs I18n.t('active_admin.quiz.quiz_details.title') do
      f.input :lesson
      f.input :title
    end

    f.inputs I18n.t('active_admin.quiz.questions.title') do
      f.has_many :quiz_questions, allow_destroy: true, heading: I18n.t('active_admin.quiz.questions.title') do |question|
        question.input :description, label: I18n.t('active_admin.quiz.quiz_details.question_description')
        question.input :answer1, label: I18n.t('active_admin.quiz.quiz_details.answer1')
        question.input :answer2, label: I18n.t('active_admin.quiz.quiz_details.answer2')
        question.input :answer3, label: I18n.t('active_admin.quiz.quiz_details.answer3')
        question.input :answer4, label: I18n.t('active_admin.quiz.quiz_details.answer4')
        question.input :correct_answer, label: I18n.t('active_admin.quiz.quiz_details.correct_answer'), as: :select, collection: [[I18n.t('active_admin.quiz.quiz_details.answer1'), 1], [I18n.t('active_admin.quiz.quiz_details.answer2'), 2], [I18n.t('active_admin.quiz.quiz_details.answer3'), 3], [I18n.t('active_admin.quiz.quiz_details.answer4'), 4]], include_blank: false
      end
    end

    f.actions
  end
end
