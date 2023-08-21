class TicketToEventMailer < ApplicationMailer

  def send_ticket
    @ticket = params[:ticket]
    mail(to: @ticket.student.email, subject: 'Ingresso para o Evento')
  end
end
