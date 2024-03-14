require 'rails_helper'

RSpec.describe Events::VisibleParticipant, type: :business_application do
  describe '#call' do
    let(:event) { double("Event", is_visible_to_registered_participants: is_visible_to_registered_participants) }

    context 'when the event is visible to registered participants' do
      let(:is_visible_to_registered_participants) { true }

      context 'when current_student_user is present' do
        let(:current_student_user) { double("User") }
        let(:visible_participant) { Events::VisibleParticipant.new(event, current_student_user) }

        it 'returns true' do
          expect(visible_participant.call).to eq(true)
        end
      end

      context 'when current_student_user not is present' do
        let(:current_student_user) { nil }
        let(:visible_participant) { Events::VisibleParticipant.new(event, current_student_user) }

        it 'returns true' do
          expect(visible_participant.call).to eq(false)
        end
      end
    end
  end
end
