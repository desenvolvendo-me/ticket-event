require 'rails_helper'

RSpec.describe Access::Checker do
  describe '#call' do
    context 'when the resource is a Lesson' do
      it 'returns false if the lesson is not available' do
        manager = create(:manager_user)
        lesson = create(:lesson, launch_datetime: Time.zone.now + 1.hour, manager_user: manager)
        checker = Access::Checker.call(lesson)
        expect(checker).to be false
      end

      it 'returns true if the lesson is available' do
        manager = create(:manager_user)
        lesson = create(:lesson, launch_datetime: Time.zone.now - 1.hour, manager_user: manager)
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
        expect(purchase_checker[:access]).to be true
        end

      it 'returns false if the event.purchase is not available' do
        event = create(:event, purchase_date: Time.zone.now + 1.hour)
        purchase_checker = Access::Checker.call(event, :purchase)
        expect(purchase_checker[:access]).to be false
      end

      it 'returns the purchase_link when the purchase is available' do
        event = create(:event, purchase_date: Time.zone.now - 1.hour)
        link = event.purchase_link
        translation = I18n.t('views.external.lesson.view_show.purchase_link')
        purchase = Access::Checker.call(event, :purchase)
        expect(purchase[:link]).to eq(link)
        expect(purchase[:i18n]).to eq(translation)
      end

      it 'returns the community_link when the purchase is NOT available' do
        event = create(:event, purchase_date: Time.zone.now + 3.hours)
        link = event.community_link
        translation = I18n.t('views.external.lesson.view_show.community_access')
        purchase = Access::Checker.call(event, :purchase)
        expect(purchase[:link]).to eq(link)
        expect(purchase[:i18n]).to eq(translation)
      end
    end

    describe 'when raise error messages' do
      context 'when the resource type is invalid' do
        it 'raises an ArgumentError' do
          resource = double('anyEventNeitherLesson')

          expect { Access::Checker.call(resource, :available) }.to raise_error(ArgumentError, I18n.t('businesses.access.checker.resource_error'))
        end
      end

      context 'when resource is valid' do
        it 'raises an ArgumentError when second argument is invalid' do
          event = create(:event)
          # without parameter :available or :purchase will raise an error
          expect { Access::Checker.call(event, :parametro_invalido) }.to raise_error(ArgumentError, I18n.t('businesses.access.checker.argument_error'))
        end
        it 'raises an ArgumentError when second argument is not declared' do
          event = create(:event)
          expect { Access::Checker.call(event) }.to raise_error(ArgumentError, I18n.t('businesses.access.checker.argument_error'))
        end
        it 'does not raises an ArgumentError when second argument is not declared and first argument is LESSON' do
          lesson = create(:lesson)
          expect { Access::Checker.call(lesson) }.to_not raise_error(ArgumentError, I18n.t('businesses.access.checker.argument_error'))
        end
      end
    end
  end
end
