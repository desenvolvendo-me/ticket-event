class AddTicketToPrizeDraws < ActiveRecord::Migration[7.0]
  def change
    add_column :prize_draws, :ticket_id, :integer
  end
end
