class CreateQuizzes < ActiveRecord::Migration[7.0]
  def change
    create_table :quizzes do |t|
      t.references :lesson, null: false, foreign_key: true
      t.string :title

      t.timestamps
    end
  end
end
