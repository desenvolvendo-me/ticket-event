module Lessons
  class CheckerFinished < BusinessApplication
    def initialize(lesson)
      @lesson = lesson
    end

    def call
      is_lesson_finished?
    end

    private

    def is_lesson_finished?
      @lesson.student_lessons.present? && @lesson.student_lessons.last.status == "finished"
    end
  end
end
