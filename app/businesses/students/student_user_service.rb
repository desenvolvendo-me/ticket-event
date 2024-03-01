# app/businesses/student_user/student_user_service.rb
module Students
  class StudentUserService
    def self.create_associated_student(student_user)
      email = student_user.email
      return if Student.exists?(email: email)

      Student.create(email: email, student_user_id: student_user.id)
    end
  end
end
