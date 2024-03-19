module Lessons
  class InitializeFirstClassForStudent < BusinessApplication
    def initialize(get_student, student_data, event, lesson_ids)
      @get_student = get_student      
      @student_data = student_data
      @event = event
      @lesson_ids = lesson_ids
    end

    def call
      if @get_student && !CheckStudentLessonWatched.new(student_data, event).call
        initialize_lessons
        :success
      else
        :already_watched_or_no_student
      end
    end

    private

    attr_reader :student_data, :event, :lesson_ids

    def initialize_lessons
      lessons_and_student = lesson_ids.map.with_index do |lesson_id, index|
        status = index == 0 ? 'progress' : 'not started'
        { student_id: student_data.id, lesson_id: lesson_id, status: status }
      end

      StudentLesson.insert_all(lessons_and_student)
    end
  end
end