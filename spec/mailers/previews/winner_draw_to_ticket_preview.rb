class WinnerDrawToTicketPreview < ActionMailer::Preview

  def send_winner_draw
    WinnerDrawToTicketMailer.with(prize_draw: PrizeDraw.last!).send_winner_draw.deliver_now
  end
end
