require 'rails_helper'

RSpec.describe Lessons::CheckStudentLessonWatched do
  describe '#call' do
    let(:student) { create(:student) } # Assumindo que você tem uma factory para students
    let(:event) { create(:event) } # Assumindo que você tem uma factory para events
    let(:lesson_ids) { [create(:lesson, event: event).id] }

    before do
      allow(Lesson).to receive(:where).with(event_id: event.id).and_return(double(pluck: lesson_ids))
    end

    context 'when the student has watched a lesson' do
      before do
        create(:student_lesson, student_id: student.id, lesson_id: lesson_ids.first, status: 'watched')
      end

      it 'returns true' do
        service = Lessons::CheckStudentLessonWatched.new(student, event)
        expect(service.call).to be true
      end
    end
  end
end
