module PrizeDraws
  class Generator < BusinessApplication

    PASSING_SCORE = 70

    def initialize(event)
      @event = event
    end

    def call
      draw_ticket
      create_prize_draw if @drawn_ticket
    end

    private

    def draw_ticket
      @drawn_ticket = @event.tickets.where("student_score >= ?", PASSING_SCORE).sample
    end

    def create_prize_draw
      PrizeDraw.create(ticket: @drawn_ticket)
    end
  end
end
