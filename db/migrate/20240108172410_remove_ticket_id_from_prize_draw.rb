class RemoveTicketIdFromPrizeDraw < ActiveRecord::Migration[7.0]
  def change
    remove_column :prize_draws, :ticket_id, :integer
  end
end
