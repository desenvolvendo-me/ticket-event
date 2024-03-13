require 'rails_helper'

RSpec.describe Lessons::Terminator do
  describe '.terminate_lesson' do
    let(:student_user) { create(:student, email: 'student@example.com') }
    let(:lesson) { create(:lesson) }

    context 'when student exists' do
      let!(:student) { create(:student, email: student_user.email) }

      context 'when student lesson is new' do
        let(:lesson_builder) { Lessons::Terminator.call(student_user, lesson.id)}
        it 'finishes the lesson' do
          student_lesson = lesson_builder
          expect(student_lesson.status).to eq('finished')
        end
      end

      context 'when student lesson already exists' do
        let!(:student_lesson) { create(:student_lesson, student: student, lesson: lesson) }
        let(:lesson_builder) { Lessons::Terminator.call(student_user, lesson.id)}

        it 'updates the lesson status' do
          student_lesson = lesson_builder
          expect(student_lesson.status).to eq('finished')
        end
      end

      context 'when lesson id is nil' do
        let!(:student_lesson) { create(:student_lesson, student: student, lesson: lesson) }
        let(:lesson_builder) { Lessons::Terminator.call(student_user, nil)}
        it 'does not terminate the lesson' do
          student_lesson = lesson_builder
          expect(student_lesson).to be_nil
        end
      end
    end
  end
end
