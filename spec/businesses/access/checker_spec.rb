require 'rails_helper'

RSpec.describe Access::Checker do
  describe '#call' do
    context 'when the resource is a Lesson' do
      it 'returns true if the lesson is not available' do
        lesson = create(:lesson, launch_datetime: Time.zone.now + 1.hour)
        checker = Access::Checker.new(lesson)
        expect(checker.call).to be true
      end

      it 'returns false if the lesson is available' do
        lesson = create(:lesson, launch_datetime: Time.zone.now - 1.hour)
        checker = Access::Checker.new(lesson)
        expect(checker.call).to be false
      end
    end

    context 'when the resource is an Event' do
      it 'returns true if the event is available' do
        event = create(:event, date: Time.zone.now + 1.hour)
        checker = Access::Checker.new(event)
        expect(checker.call).to be true
      end

      it 'returns false if the event is not available' do
        event = create(:event, date: Time.zone.now - 1.hour)
        checker = Access::Checker.new(event)
        expect(checker.call).to be false
      end
    end

    context 'when the resource type is invalid' do
      it 'raises an ArgumentError' do
        resource = double('anyEventNeitherLesson')
        checker = Access::Checker.new(resource)
        expect { checker.call }.to raise_error(ArgumentError, I18n.t('businesses.access.checker.argument_error'))
      end
    end
  end
end
