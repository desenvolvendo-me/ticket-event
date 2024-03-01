module Lessons
  class Terminator
    def self.terminate_lesson(student_user, lesson_id)
      student = Student.find_by(email: student_user.email)
      return unless student

      student_lesson = StudentLesson.find_or_initialize_by(student_id: student.id, lesson_id: lesson_id)
      now = Time.now

      if student_lesson.new_record?
        student_lesson.assign_attributes(status: "finished", created_at: now, updated_at: now)
      else
        student_lesson.update(status: "finished", updated_at: now)
      end

      student_lesson.save
      student_lesson
    end
  end
end
