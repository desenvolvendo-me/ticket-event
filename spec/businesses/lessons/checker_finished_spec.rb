require 'rails_helper'

RSpec.describe Lessons::CheckerFinished do
  describe '#is_lesson_finished' do
    let(:lesson) { create(:lesson) }

    context 'when student lesson status not is finished' do
      before do
        create(:student_lesson, lesson: lesson, status: 'not started')
      end

      it 'returns false' do
        expect(lesson.is_lesson_finished).to eq(false)
      end
    end

    context 'when at least one student lesson is finished' do
      before do
        create(:student_lesson, lesson: lesson, status: 'finished')
      end

      it 'returns true' do
        expect(lesson.is_lesson_finished).to eq(true)
      end
    end
  end
end
