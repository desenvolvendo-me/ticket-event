require 'rails_helper'

RSpec.describe Lessons::LessonValidator do
  let(:event) { create(:event) }

  describe '#call' do
    context 'when the event has less than 5 lessons' do
      it 'does not add an error to the lesson' do
        lesson = create(:lesson, event: event)

        validator = Lessons::LessonValidator.new(lesson)
        validator.call

        expect(lesson.errors).to be_empty
      end
    end

    context 'when the event has 5 lessons' do
      it 'adds an error when create a lesson' do
        lessons = create_list(:lesson, 5, event: event)

        validator = Lessons::LessonValidator.new(lessons.first)
        validator.call

        expect(lessons.first.errors).to_not be_empty
      end
    end
  end
end
