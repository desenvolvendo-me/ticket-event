class ChangeCorrectAnswerTypeInQuizQuestions < ActiveRecord::Migration[7.0]
  def up
    change_column :quiz_questions, :correct_answer, 'integer USING CAST(correct_answer AS integer)'
  end

  def down
    change_column :quiz_questions, :correct_answer, :string
  end
end
