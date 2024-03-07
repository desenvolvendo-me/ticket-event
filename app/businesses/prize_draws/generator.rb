# frozen_string_literal: true
module PrizeDraws
  class Generator < BusinessApplication
    PASSING_SCORE = 70

    def initialize(event, prize_draw)
      @prize_draw = prize_draw
      @event = event
    end

    def call
      draw_ticket

    end

    private

    def draw_ticket
      @drawn_ticket = @event.tickets.where('student_score >= ?', PASSING_SCORE).sample
      send_mailer if @drawn_ticket.present?

    end
    def send_mailer
      PrizeDraw.create(ticket_id: @drawm_ticket)
      WinnerDrawToTicketMailer.with(prize_draw: @prize_draw, ticket: @drawn_ticket).send_winner_draw.deliver_now
    end
  end
end
