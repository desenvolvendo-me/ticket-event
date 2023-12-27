class AddWinnerTicketToPrizeDraw < ActiveRecord::Migration[7.0]
  def change
    add_column :prize_draws, :winner_ticket, :string
  end
end
