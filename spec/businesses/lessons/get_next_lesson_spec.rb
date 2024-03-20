require 'rails_helper'

RSpec.describe Lessons::GetNextLesson do
  describe '#call' do
    let(:lesson1) { double('Lesson', id: 1) }
    let(:lesson2) { double('Lesson', id: 2) }
    let(:lessons) { [lesson1, lesson2] }

    context 'when the next lesson exists' do
      subject { described_class.new(lesson1, lessons).call }

      it 'returns the next lesson' do
        expect(subject).to eq(lesson2)
      end
    end
  end
end
