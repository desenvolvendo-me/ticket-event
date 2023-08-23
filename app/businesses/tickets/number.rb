module Tickets
  class Number < BusinessApplication
    def initialize(ticket:)
      @ticket = ticket
    end

    def call
      loop do
        number = SecureRandom.random_number(1..99_999)
        @ticket.number = number.to_s.rjust(5, '0')
        break unless @ticket.class.exists?(number: number)
      end
    end
  end
end
