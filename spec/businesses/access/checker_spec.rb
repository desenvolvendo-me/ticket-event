require 'rails_helper'

RSpec.describe Access::Checker do
  describe '#call' do
    context 'when the resource is a Lesson' do
      it 'returns false if the lesson is not available' do
        lesson = create(:lesson, launch_datetime: Time.zone.now + 1.hour)
        checker = Access::Checker.call(lesson)
        expect(checker).to be false
      end

      it 'returns true if the lesson is available' do
        lesson = create(:lesson, launch_datetime: Time.zone.now - 1.hour)
        checker = Access::Checker.call(lesson)
        expect(checker).to be true
      end
    end

    context 'when the resource is an Event' do
      it 'returns true if the event is available' do
        event = create(:event, date: Time.zone.now + 1.hour)
        checker = Access::Checker.call(event, :available)
        expect(checker).to be true
      end

      it 'returns false if the event is not available' do
        event = create(:event, date: Time.zone.now - 1.hour)
        checker = Access::Checker.call(event, :available)
        expect(checker).to be false
        end

      it 'returns true if the event.purchase is not available' do
        event = create(:event, purchase_date: Time.zone.now - 1.hour)
        purchase_checker = Access::Checker.call(event, :purchase)
        expect(purchase_checker).to be true
        end

      it 'returns false if the event.purchase is not available' do
        event = create(:event, purchase_date: Time.zone.now + 1.hour)
        purchase_checker = Access::Checker.call(event, :purchase)
        expect(purchase_checker).to be false
      end
    end

    describe 'when raise error messages' do
      context 'when the resource type is invalid' do
        it 'raises an ArgumentError' do
          resource = double('anyEventNeitherLesson')

          expect { Access::Checker.call(resource, :available) }.to_not raise_error(ArgumentError, I18n.t('businesses.access.checker.resource_error'))
        end
      end

      context 'when resource is valid but date argument is invalid' do
        it 'raises an ArgumentError' do
          event = create(:event)
          # without parameter :date or purchase_date will raise an error
          expect { Access::Checker.call(event, :purchase_date) }.to_not raise_error(ArgumentError, I18n.t('businesses.access.checker.argument_error'))
        end
      end
    end
  end
end
