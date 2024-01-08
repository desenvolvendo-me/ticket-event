module PrizeDraws
  class Generator < BusinessApplication
    PASSING_SCORE = 70

    def initialize( prize_draw)
      @prize_draw = prize_draw
    end

    def call
      draw_ticket
    end

    private

    def draw_ticket
      eligible_tickets = @prize_draw.tickets.where("student_score >= ?", PASSING_SCORE)
      @drawn_ticket = eligible_tickets.sample

      if @drawn_ticket.present?
        WinnerTicket.create(prize_draw: @prize_draw, ticket: @drawn_ticket, winner: @drawn_ticket.student.name)
      end

      @drawn_ticket
    end
  end
end
