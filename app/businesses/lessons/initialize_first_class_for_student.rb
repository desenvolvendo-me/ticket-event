module Lessons
  class InitializeFirstClassForStudent < BusinessApplication
    def initialize(student_data, event, lesson_ids)
      @student_data = student_data
      @event = event
      @lesson_ids = lesson_ids
    end

    def call
      if @student_data && !CheckStudentLessonWatched.new(@student_data, @event).call
        initialize_lessons
        :success
      else
        :already_watched_or_no_student
      end
    end

    private

    attr_reader :student_data, :event, :lesson_ids

    def initialize_lessons
      if lesson_ids
        lessons_and_student = lesson_ids.map.with_index do |lesson_id, index|
          status = index == 0 ? 'progress' : 'not started'
          { student_id: student_data.id, lesson_id: lesson_id, status: status }
        end

        StudentLesson.insert_all(lessons_and_student)
      end
    end
  end
end
