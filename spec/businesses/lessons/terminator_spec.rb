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

      context 'when student lesson already exists' do
        let!(:student_lesson) { create(:student_lesson, student: student, lesson: lesson) }

        it 'updates the lesson status' do
          student_lesson = described_class.terminate_lesson(student_user, lesson.id)
          expect(student_lesson.status).to eq('finished')
        end
      end

      context 'when lesson id is nil' do
        let!(:student_lesson) { create(:student_lesson, student: student, lesson: lesson) }
        it 'does not terminate the lesson' do
          student_lesson = described_class.terminate_lesson(student_lesson, nil)
          expect(student_lesson).to be_nil
        end
      end
    end

    context 'when student does not exist' do
      it 'does not terminate the lesson' do
        student_lesson = described_class.terminate_lesson(nil, lesson.id)
        expect(student_lesson).to be_nil
      end
    end
  end
end
