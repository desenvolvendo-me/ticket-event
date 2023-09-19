class CreateQuizQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :quiz_questions do |t|
      t.string :description
      t.string :answer1
      t.string :answer2
      t.string :answer3
      t.string :answer4
      t.string :correct_answer
      t.references :quiz, null: false, foreign_key: true

      t.timestamps
    end
  end
end
