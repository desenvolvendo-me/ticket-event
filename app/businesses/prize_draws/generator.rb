module PrizeDraws
  class Generator < BusinessApplication

    PASSING_SCORE = 70

    def initialize(event, prize_draw)
      @event = event
      @prize_draw = prize_draw
    end

    def call
      draw_ticket
      @drawn_ticket if prize_draw_in_progress?
    end

    private

    def draw_ticket
      @drawn_ticket = @event.tickets.where("student_score >= ?", PASSING_SCORE).sample
    end
    def prize_draw_in_progress?
      @prize_draw.present?
    end
  end
end
