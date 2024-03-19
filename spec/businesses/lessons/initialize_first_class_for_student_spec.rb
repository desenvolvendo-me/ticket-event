require 'rails_helper'

RSpec.describe Lessons::InitializeFirstClassForStudent do
  describe '#call' do
    let(:student_data) { create(:student) }
    let(:event) { create(:event) }
    let(:lesson_ids) { create_list(:lesson, 3, event: event).map(&:id) }
    let(:watched_checker) { instance_double("Lessons::CheckStudentLessonWatched") }

    context 'when the student exists and has not watched any lesson' do
      it 'initializes the first class and returns :success' do
        allow(Lessons::CheckStudentLessonWatched).to receive(:new).and_return(watched_checker)
        allow(watched_checker).to receive(:call).and_return(false)

        service = described_class.new(true, student_data, event, lesson_ids)
        expect(service.call).to eq(:success)

        expect(StudentLesson.where(student_id: student_data.id).count).to eq(3)
        expect(StudentLesson.find_by(lesson_id: lesson_ids.first).status).to eq('not started')
        lesson_ids[1..-1].each do |id|
          expect(StudentLesson.find_by(lesson_id: id).status).to eq('not started')
        end
      end
    end
    
    context 'when the student does not exist or has already watched a lesson' do
      it 'returns :already_watched_or_no_student' do
        allow(Lessons::CheckStudentLessonWatched).to receive(:new).and_return(watched_checker)
        allow(watched_checker).to receive(:call).and_return(true)

        service = described_class.new(false, nil, event, lesson_ids)
        expect(service.call).to eq(:already_watched_or_no_student)
      end
    end
  end
end
