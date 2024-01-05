class ChangeColumnTypeInPrizeDraw < ActiveRecord::Migration[7.0]
  def change
    change_column :prize_draws, :event_id, :bigint
  end
end
