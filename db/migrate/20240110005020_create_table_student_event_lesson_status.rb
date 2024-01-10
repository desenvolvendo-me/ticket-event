class CreateTableStudentEventLessonStatus < ActiveRecord::Migration[7.0]
  def change
    create_table :table_student_event_lesson_statuses do |t|
      t.references :student, foreign_key: true
      t.references :event, foreign_key: true
      t.references :lesson, foreign_key: true
      t.boolean :is_finished

      t.timestamps
    end
  end
end
