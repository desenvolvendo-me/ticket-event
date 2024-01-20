require 'rails_helper'

RSpec.describe PrizeDraws::Generator do
  let(:event) { create(:event) }
  let(:prize_draw) { create(:prize_draw, event: event) }
  let(:ticket) { create(:ticket, event: event) }


  context '#call' do
    it 'draws a ticket and creates a winner ticket' do
      student = create(:student)
      drawn_ticket  = create(:ticket, event: event, student: student, student_score: 70, prize_draw: prize_draw)

      allow(event.tickets).to receive(:where).and_return([drawn_ticket ])
      allow(event.tickets).to receive(:sample).and_return(drawn_ticket )

      PrizeDraws::Generator.call(event, prize_draw)

      expect(drawn_ticket.student_id).to eq(student.id)
      expect(drawn_ticket.event_id).to eq(event.id)
      expect(drawn_ticket).to be_instance_of(Ticket)

    end

    it 'does not create a winner ticket if no eligible ticket is drawn' do
      allow(event.tickets).to receive(:where).and_return([])
      allow(event.tickets).to receive(:sample).and_return(nil)

      drawn_ticket = PrizeDraws::Generator.call(event, prize_draw)

      expect(drawn_ticket).to be_nil

    end
  end
end
