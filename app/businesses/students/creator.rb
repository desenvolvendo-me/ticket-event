module Students
  class Creator < BusinessApplication

    def initialize(row)
      @row = row
    end

    def call
      create_student(@row)
    end

    private

    def create_student(row)
      Student.create(
        email: row["email"],
        phone: row["phone"],
        name: row["fullname"],
        profile_social: row["profile_social"],
        type_social: row["type_social"],
        student_user_id: row["student_id"]
      )
    end
  end
end