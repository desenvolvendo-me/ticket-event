class AddReferenceEventIdToPrizeDraw < ActiveRecord::Migration[7.0]
  def change
    add_reference :prize_draws, :event, null: false, foreign_key: true
  end
end
