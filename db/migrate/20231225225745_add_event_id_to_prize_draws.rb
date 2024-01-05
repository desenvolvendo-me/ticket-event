class AddEventIdToPrizeDraws < ActiveRecord::Migration[7.0]
  def change
    add_column :prize_draws, :event_id, :integer, null: false
  end
end
