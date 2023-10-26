require 'rails_helper'

RSpec.describe Students::CsvStudentRegister do
  let(:csv_path) { "spec/support/leads_export.csv" }
  let!(:csv_data) { CSV.read(csv_path, headers: true).first }

  subject(:csv_student_register) do
    Students::CsvStudentRegister.call(csv_path: csv_path)
  end

  describe "#call" do
    let(:last_student_created) { Student.last }

    context "when the CSV data is successfully processed" do

      it "increases the Student count and ensures the new Student info matches the CSV data" do

        expect { csv_student_register }.to change(Student, :count).by(1)
        expect(last_student_created.email).to eq(csv_data["email"])
        expect(last_student_created.phone).to eq(csv_data["phone"])
        expect(last_student_created.name).to eq(csv_data["fullname"])
        expect(last_student_created.profile_social).to eq(csv_data["profile_social"])
        expect(last_student_created.type_social).to eq(csv_data["type_social"])
      end
    end
  end
end
