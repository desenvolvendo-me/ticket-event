module PrizeDraws
  class Generator < BusinessApplication
    def initialize(event)
      @event = event
    end

    def call
      draw_winner
      create_prize_draw
    end

    private

    def draw_winner
      @winner = @event.tickets.map(&:student).sample
    end

    def create_prize_draw
      PrizeDraw.create(event: @event, winner: @winner)
    end
  end
end
