class AddColumnWinnerToWinnerTickets < ActiveRecord::Migration[7.0]
  def change
    add_column :winner_tickets, :winner, :string
  end
end
