require 'rails_helper'

RSpec.describe Students::CsvStudentRegister do
  let(:event) { create(:event) }
  let(:csv_path) {'spec/support/leads_export.csv'}
  let(:csv_student_register) {Students::CsvStudentRegister.new(event: event, csv_path: csv_path)}

  it 'change image student' do
    csv_student_register.call

  end
end