module Lessons
  class GetNextLesson < BusinessApplication

    def initialize(lesson, lessons)
      @lesson = lesson
      @lessons = lessons
    end

    def call
      get_next_lesson
    end

    private

    attr_reader :lesson, :lessons

    def get_next_lesson
      return nil if @lessons.nil? || @lessons.empty?

      current_index = @lessons.index(@lesson)
      return @lesson if current_index.nil?

      next_index = current_index + 1

      if next_index < @lessons.length
        @lessons[next_index]
      else
        @lesson
      end
    end
  end
end
