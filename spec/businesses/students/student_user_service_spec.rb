require 'rails_helper'

RSpec.describe Students::StudentUserService, type: :service do
  describe '.create_associated_student' do
    let(:student_user) { create(:student_user) }

    context 'when a student with the same email does not exist' do
      it 'creates a new associated student' do
        expect {
          described_class.create_associated_student(student_user)
        }.to change(Student, :count).by(1)
      end
    end
  end
end
