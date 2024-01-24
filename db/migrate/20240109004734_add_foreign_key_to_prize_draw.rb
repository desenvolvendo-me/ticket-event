class AddForeignKeyToPrizeDraw < ActiveRecord::Migration[7.0]
  def change
    add_reference :prize_draws, :ticket,  foreign_key: true
  end
end
