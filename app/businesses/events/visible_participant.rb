module Events
  class VisibleParticipant < BusinessApplication
    attr_reader :event, :current_student_user

    def initialize(event, current_student_user)
      @event = event
      @current_student_user = current_student_user
    end

    def call
      unless @event.is_visible_to_registered_participants
        true
      else
        @current_student_user.present?
      end
    end
  end
end
