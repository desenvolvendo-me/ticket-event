# app/businesses/student_users/associate_student.rb
module StudentUsers
  class AssociateStudent < BusinessApplication
    def initialize(student_user)
      @student_user = student_user
    end

    def call
      associated_student
    end

    private

    def associated_student
      email = @student_user.email
      return if Student.exists?(email: email)

      Student.create(email: email, student_user_id: @student_user.id)
    end
  end
end
