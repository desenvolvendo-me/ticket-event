require 'rails_helper'

RSpec.describe PrizeDraws::Generator do
  let(:event) { create(:event) }
  let(:prize_draw) { create(:prize_draw, event: event) }
  let(:ticket) { create(:ticket, event: event) }

  context '#call' do
    it 'draws a ticket and creates a winner ticket' do
      student = create(:student)
      eligible_ticket = create(:ticket, event: event, student: student, student_score: 70)

      allow(event.tickets).to receive(:where).and_return([eligible_ticket])
      allow(event.tickets).to receive(:sample).and_return(eligible_ticket)

      drawn_winner_ticket = PrizeDraws::Generator.call(event, prize_draw)

      expect(WinnerTicket.count).to eq(1)
      expect(WinnerTicket.first.prize_draw).to eq(prize_draw)
      expect(WinnerTicket.first.ticket).to eq(eligible_ticket)
      expect(WinnerTicket.first.winner).to eq(student.name)
      expect(WinnerTicket.first.prize_draw.id).to eq(prize_draw.id)
      expect(WinnerTicket.first.ticket.student.name).to eq(student.name)


    end

    it 'does not create a winner ticket if no eligible ticket is drawn' do
      allow(event.tickets).to receive(:where).and_return([])
      allow(event.tickets).to receive(:sample).and_return(nil)

      drawn_ticket = PrizeDraws::Generator.call(event, prize_draw)

      expect(drawn_ticket).to be_nil
      expect(WinnerTicket.count).to eq(0)
    end
  end
end
