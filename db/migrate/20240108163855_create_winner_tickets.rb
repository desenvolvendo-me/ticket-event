class CreateWinnerTickets < ActiveRecord::Migration[7.0]
  def change
    create_table :winner_tickets do |t|

      t.references :prize_draw, null: false, foreign_key: true
      t.references :ticket, null: false, foreign_key: true

      t.timestamps
    end
  end
end
