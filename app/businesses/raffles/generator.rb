module Raffles
  class Generator < BusinessApplication
    def initialize(event)
      @event = event
    end

    def call
      raffle_winner
      create_raffle
    end

    private

    def raffle_winner
      @winner = @event.tickets.map(&:student).sample
    end

    def create_raffle
      Raffle.create(event: @event, winner: @winner)
    end
  end
end
