module Events
  class HappeningNow < BusinessApplication
    attr_reader :event

    def initialize(event)
      @event = event
    end

    def call
      @event.is_visible_during_event && happening_now?
    end

    private

    def happening_now?
      current_time = Time.current
      event_start = @event.date
      event_end = event_start + @event.duration.hours

      current_time >= event_start && current_time <= event_end
    end
  end
end
