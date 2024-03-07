class WinnerDrawToTicketMailer < ApplicationMailer
  def send_winner_draw
    @prize_draw = params[:prize_draw]
    @ticket = params[:ticket]
    mail(to: @ticket.student.email, subject: t('.subject', name: @ticket.student.name))
  end
end
