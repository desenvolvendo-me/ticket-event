module Events
  class Validator < BusinessApplication
    attr_reader :errors

    def initialize(event)
      @event = event
      @errors = []
    end

    def call
      validate_duration_format
      validate_visibility_fields
      @errors
    end

    private

    def validate_duration_format
      unless @event.duration.is_a?(Integer) && @event.duration.positive?
        @errors << { duration: I18n.t("businesses.event.validator.duration") }
      end
    end

    def validate_visibility_fields
      if @event.is_visible_after_time?
        if @event.visible_after_time.blank?
          @errors << { visible_after_time: I18n.t("businesses.event.validator.after_time") }
        end
      end
    end
  end
end
