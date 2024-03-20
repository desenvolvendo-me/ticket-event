module Lessons
  class GetPreviousLesson < BusinessApplication

    def initialize(lesson, lessons)
      @lesson = lesson
      @lessons = lessons
    end

    def call
      get_previous_lesson
    end

    private

    attr_reader :lesson, :lessons

    def get_previous_lesson
      return nil if @lessons.nil? || @lessons.empty?

      current_index = @lessons.index(@lesson)
      return nil if current_index.nil? || current_index.zero?

      previous_index = current_index - 1
      @lessons[previous_index]
    end
  end
end
