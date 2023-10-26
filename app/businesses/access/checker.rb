module Access
  class Checker < BusinessApplication
    def initialize(resource)
      @resource = resource
    end

    def call
      available?
    end

    private

    def available?
      if @resource.is_a?(Lesson)
        lesson_available?
      elsif @resource.is_a?(Event)
        event_available?
      else
        raise ArgumentError, I18n.t('businesses.access.checker.argument_error')
      end
    end

    def lesson_available?
      @resource.launch_datetime > Time.zone.now
    end

    def event_available?
      @resource.date > Time.zone.now
    end
  end
end
