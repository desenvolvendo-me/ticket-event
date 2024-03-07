class RemovePrizeDrawIdFromTickets < ActiveRecord::Migration[7.0]
  def change
    remove_column :tickets, :prize_draw_id
  end
end
