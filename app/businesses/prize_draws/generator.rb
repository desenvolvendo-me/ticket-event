module PrizeDraws
  class Generator < BusinessApplication
    def initialize(event)
      @event = event
    end

    def call
      draw_ticket
      create_prize_draw
    end

    private

    def draw_ticket
      @drawn_ticket = @event.tickets.sample
    end

    def create_prize_draw
      PrizeDraw.create(ticket: @drawn_ticket)
    end
  end
end
