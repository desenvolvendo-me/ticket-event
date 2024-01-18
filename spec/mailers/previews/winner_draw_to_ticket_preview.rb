# Preview all emails at http://localhost:3000/rails/mailers/winner_draw_to_ticket
class WinnerDrawToTicketPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/winner_draw_to_ticket/send_winner_draw
  def send_winner_draw
    WinnerDrawToTicketMailer.with(prize_draw: PrizeDraw.last.winner).send_winner_draw.deliver_later
  end
end
