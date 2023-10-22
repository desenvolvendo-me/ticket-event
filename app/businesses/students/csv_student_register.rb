module Students
  class CsvStudentRegister < BusinessApplication

    def initialize(event:, csv_path:)
      @event = event
      @csv_path = csv_path
    end

    def call
      process_csv
    end

    private

    def process_csv
      CSV.foreach(@csv_path, headers: true) do |row|
        create_student(row)
      end
    end

    def create_student(row)
      Student.create(
        email: row["email"],
        phone: row["phone"],
        name: row["fullname"]
      )
    end
  end
end