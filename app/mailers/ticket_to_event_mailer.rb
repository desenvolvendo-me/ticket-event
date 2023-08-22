class TicketToEventMailer < ApplicationMailer

  def send_ticket
    @ticket = params[:ticket]
    mail(to: @ticket.student.email, subject: "Seu Ingresso para o Evento: #{@ticket.event.name}")
  end
end
