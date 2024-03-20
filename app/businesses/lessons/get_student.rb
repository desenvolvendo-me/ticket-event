module Lessons
  class GetStudent < BusinessApplication

    def initialize(student_user_signed_in, current_student_user)
      @student_user_signed_in = student_user_signed_in
      @current_student_user = current_student_user
    end

    def call
      get_student
    end

    private

    attr_reader :student_user_signed_in, :current_student_user

    def get_student
      if student_user_signed_in
        return current_student_user.student
      else
        return nil
      end
    end
  end
end
