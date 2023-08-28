# Preview all emails at http://localhost:3000/rails/mailers/ticket_to_event
class TicketToEventPreview < ActionMailer::Preview
  def send_ticket
    TicketToEventMailer.with(ticket: Ticket.last).send_ticket.deliver_now
  end
end
