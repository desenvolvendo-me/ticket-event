class CreateStudentEventLessonStatuses < ActiveRecord::Migration[7.0]
  def change
    create_table :student_event_lesson_statuses do |t|
      t.references :event, null: false, foreign_key: true
      t.references :student, null: false, foreign_key: true
      t.references :lesson, null: false, foreign_key: true
      t.boolean :is_finished

      t.timestamps
    end
  end
end
