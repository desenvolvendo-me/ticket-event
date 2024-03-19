require 'rails_helper'

RSpec.describe Lessons::GetStudent, type: :service do
  describe '#call' do
    context 'when student_user is signed in' do
      let(:student) { double('Student') } # Simula o objeto Student
      let(:current_student_user) { double('User', student: student) } # Simula o objeto User com um student associado

      it 'returns the student associated with current_student_user' do
        service = Lessons::GetStudent.new(true, current_student_user)
        expect(service.call).to eq(student)
      end
    end
  end
end
