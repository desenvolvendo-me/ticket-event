module Notifications
  class Notifier < BusinessApplication
    def initialize(ticket: nil)
      @ticket = ticket
    end

    def call
      if @ticket
        if @ticket.png.attached?
          TicketToEventMailer.with(ticket: @ticket).send_ticket.deliver_now
          @ticket.update(send_email_at: Time.now)
        end
      else
        Ticket.not_send_email.each do |ticket|
          if ticket.png.attached?
            TicketToEventMailer.with(ticket: ticket).send_ticket.deliver_now
            ticket.update(send_email_at: Time.now)
          end
        end
      end
    end
  end
end
