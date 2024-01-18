class AddColumnNumberTicketToPrizeDraw < ActiveRecord::Migration[7.0]
  def change
    add_column :prize_draws, :number_ticket, :string
  end
end
