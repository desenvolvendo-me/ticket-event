require 'rails_helper'

RSpec.describe Lessons::Terminator do
  describe '.terminate_lesson' do
    let(:student_user) { create(:student, email: 'student@example.com') }
    let(:lesson) { create(:lesson) }

    context 'when student exists' do
      let!(:student) { create(:student, email: student_user.email) }

      context 'when student lesson is new' do
        it 'finishes the lesson' do
          student_lesson = described_class.terminate_lesson(student_user, lesson.id)
          expect(student_lesson.status).to eq('finished')
        end
      end
    end
  end
end
