class ChangePrizeDrawTable < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :prize_draws, :events
    remove_index :prize_draws, :event_id
    remove_column :prize_draws, :event_id

    remove_foreign_key :prize_draws, column: :winner_id
    remove_index :prize_draws, :winner_id
    remove_column :prize_draws, :winner_id

    add_reference :prize_draws, :ticket, null: false, foreign_key: true
  end
end
