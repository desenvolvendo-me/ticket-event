class AvailabilityChecker
  def self.lesson_available?(lesson)
    lesson.launch_datetime > Time.zone.now ? true : false
  end

  def self.event_available?(event)
    event.date > Time.zone.now ? true : false
  end
end
