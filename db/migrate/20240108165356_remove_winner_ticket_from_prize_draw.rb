class RemoveWinnerTicketFromPrizeDraw < ActiveRecord::Migration[7.0]
  def change
    remove_column :prize_draws, :winner_ticket, :string
  end
end
