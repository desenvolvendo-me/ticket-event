class CreateStudentLessons < ActiveRecord::Migration[7.0]
  def change
    create_table :student_lessons do |t|
      t.references :student, foreign_key: true
      t.references :lesson, foreign_key: true
      t.string :status, default: 'not started'

      t.timestamps
    end
  end
end
