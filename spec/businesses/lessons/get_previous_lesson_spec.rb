require 'rails_helper'

RSpec.describe Lessons::GetPreviousLesson do
  describe '#get_previous_lesson' do
    let(:lesson1) { double('Lesson', id: 1) }
    let(:lesson2) { double('Lesson', id: 2) }
    let(:lessons) { [lesson1, lesson2] }

    context 'when the previous lesson exists' do
      subject { described_class.new(lesson2, lessons).call }

      it 'returns the previous lesson' do
        expect(subject).to eq(lesson1)
      end
    end
  end
end
