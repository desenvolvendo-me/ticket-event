class AddNumberToTicket < ActiveRecord::Migration[7.0]
  def change
    add_column :tickets, :number, :string
  end
end
