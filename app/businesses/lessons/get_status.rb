module Lessons
  class GetStatus < BusinessApplication
    def initialize(student, lesson)
      @lesson = lesson
      @student = student
    end

    def call
      get_status
    end
    
    private

    def get_status
      @status_lesson = StudentLesson.where(student_id: @student, lesson_id: @lesson).pluck(:status)

      if @status_lesson[0] == "progress"
        @status_lesson = "progress"
      elsif @status_lesson[0] == "finished"
        @status_lesson = "finished"
      else
        @status_lesson = "not started"
      end

      return @status_lesson
    end
  end
end
