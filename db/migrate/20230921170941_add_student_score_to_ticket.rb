class AddStudentScoreToTicket < ActiveRecord::Migration[7.0]
  def change
    add_column :tickets, :student_score, :integer
  end
end
