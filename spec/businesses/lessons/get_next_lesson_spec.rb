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

    context 'when the current lesson is the last one' do
      subject { described_class.new(lesson2, lessons).call }

      it 'returns the current lesson' do
        expect(subject).to eq(lesson2)
      end
    end

    context 'when lessons is nil' do
      let(:lessons) { nil }
      subject { described_class.new(lesson1, lessons).call }

      it 'returns nil' do
        expect(subject).to be_nil
      end
    end

    context 'when lessons is empty' do
      let(:lessons) { [] }
      subject { described_class.new(lesson1, lessons).call }

      it 'returns nil' do
        expect(subject).to be_nil
      end
    end
  end
end
