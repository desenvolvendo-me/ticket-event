module Events
  class VisibleAfterTime < BusinessApplication
    attr_reader :event

    def initialize(event)
      @event = event
    end

    def call
      unless @event.is_visible_after_time
        true
      else
        after_time?
      end
    end

    private

    def after_time?
      current_time = Time.now
      current_hour = current_time.hour * 3600 + current_time.min * 60 + current_time.sec
      visible_hour = @event.visible_after_time.hour * 3600 + @event.visible_after_time.min * 60 + @event.visible_after_time.sec
      current_hour >= visible_hour
    end
  end
end
