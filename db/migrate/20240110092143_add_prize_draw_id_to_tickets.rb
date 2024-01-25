class AddPrizeDrawIdToTickets < ActiveRecord::Migration[7.0]
  def change
    add_reference :tickets, :prize_draw,  foreign_key: true
  end
end
