module Lessons
  class Validator
    def initialize(lesson)
      @lesson = lesson
    end

    def call
      validate_max_lessons_per_event
    end

    private

    def validate_max_lessons_per_event
      I18n.t("businesses.lesson.validator.max_lessons") + "#{@lesson.event.name}" if @lesson.event.lessons.count >= 5
    end
  end
end
