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
      drawn_ticket = @event.tickets.where("student_score >= ?", PASSING_SCORE).sample
      if drawn_ticket.present?
        drawn_ticket
      else
        nil
      end
    end
  end
end
