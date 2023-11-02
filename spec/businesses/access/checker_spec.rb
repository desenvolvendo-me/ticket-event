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
        checker = Access::Checker.call(event, :date)
        expect(checker).to be true
      end

      it 'returns false if the event is not available' do
        event = create(:event, date: Time.zone.now - 1.hour)
        checker = Access::Checker.call(event, :date)
        expect(checker).to be false
      end

      it 'returns a hash when the @event.purchase_date is available' do
        # Dado
        event = create(:event, purchase_date: Time.zone.now - 1.hour)
        # Quando
        result = Access::Checker.call(event, :purchase_date)
        # Então
        expect(result[:link]).to eq(event.purchase_link)
        expect(result[:i18n]).to eq(I18n.t('views.external.lesson.view_show.purchase_link'))
      end
      it 'returns other hash when the @event.purchase_date is not available' do
        # Dado
        event = create(:event, purchase_date: Time.zone.now + 1.hour)
        # Quando
        result = Access::Checker.call(event, :purchase_date)
        # Então
        expect(result[:link]).to eq(event.community_link)
        expect(result[:i18n]).to eq(I18n.t('views.external.lesson.view_show.community_access'))
      end
    end

    describe 'when raise error messages' do
      context 'when the resource type is invalid' do
        it 'raises an ArgumentError' do
          resource = double('anyEventNeitherLesson')

          expect { Access::Checker.call(resource, :date) }.to raise_error(ArgumentError, I18n.t('businesses.access.checker.resource_error'))
        end
      end

      context 'when resource is valid but date argument is invalid' do
        it 'raises an ArgumentError' do
          event = create(:event)
          # without parameter :date or purchase_date will raise an error
          expect { Access::Checker.call(event) }.to raise_error(ArgumentError, I18n.t('businesses.access.checker.argument_error'))
        end
      end
    end
  end
end
