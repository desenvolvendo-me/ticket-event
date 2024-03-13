class AddStudentToStudentUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :students, :student_user, null: true, foreign_key: true
  end
end
