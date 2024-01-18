class WinnerDrawToTicketMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.winner_draw_to_ticket_mailer.winner_draw.subject
  #
  def send_winner_draw
    mail(to: ticket.email, subject: 'Parabéns, você ganhou o sorteio!') do |format|
      format.text { render plain: "Parabéns, #{@prize_draw.winner}, você ganhou o sorteio!" }
    end
  end
end
