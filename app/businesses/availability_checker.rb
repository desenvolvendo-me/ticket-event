class AvailabilityChecker
  def self.lesson_available?(lesson)
    lesson.launch_datetime > Time.zone.now ? true : false
  end
end