class LessonValidator
  def initialize(lesson)
    @lesson = lesson
  end
  def call
    validate_max_lessons_per_event
  end

  private
  def validate_max_lessons_per_event
    if @lesson.event.lessons.count >= 5
      @lesson.errors.add(:event, I18n.t("lesson.max_lessons") + "#{@lesson.event.name}")
    end
  end
end
