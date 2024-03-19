require 'rails_helper'

RSpec.describe Lessons::GetStatus do
  describe '#call' do
    let(:student) { double(:student) }
    let(:lesson) { double(:lesson) }
    let(:status) { ['status_placeholder'] }
    let(:student_lesson_double) { double('StudentLesson') }

    before do
      allow(student_lesson_double).to receive(:pluck).with(:status).and_return(status)
      allow(StudentLesson).to receive(:where).with(student_id: student, lesson_id: lesson).and_return(student_lesson_double)
    end

    context 'when the lesson status is "progress"' do
      let(:status) { ['progress'] }

      it 'returns "progress"' do
        result = described_class.new(student, lesson).call
        expect(result).to eq('progress')
      end
    end
  end
end
