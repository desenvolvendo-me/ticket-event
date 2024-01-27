class AddStudentToStudentUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :student_users, :student, foreign_key: true
  end
end
