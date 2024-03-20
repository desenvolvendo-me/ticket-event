module Lessons
  class CheckStudentLessonWatched < BusinessApplication
    def initialize(student_data, event)
      @student_data = student_data
      @event = event
    end

    def call
      student_has_watched?
    end

    private

    attr_reader :student_data, :event

    def student_has_watched?
      if student_data.present?
        lesson_ids = Lesson.where(event_id: event.id).pluck(:id)
        StudentLesson.where(student_id: student_data.id, lesson_id: lesson_ids).exists?
      else
        false
      end
    end
  end
end
