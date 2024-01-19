class WinnerDrawToTicketMailer < ApplicationMailer
  def send_winner_draw
    @prize_draw = params[:prize_draw]
    mail(to: @prize_draw.ticket_email, subject: "Parabéns, #{@prize_draw.winner} você ganhou o sorteio!")
  end
end
