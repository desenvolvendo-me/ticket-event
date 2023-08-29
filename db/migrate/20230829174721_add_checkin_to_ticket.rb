class AddCheckinToTicket < ActiveRecord::Migration[7.0]
  def change
    add_column :tickets, :checkin, :boolean
  end
end
