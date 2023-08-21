class AddSendEmailAtInTicket < ActiveRecord::Migration[7.0]
  def change
    add_column :tickets, :send_email_at, :datetime
  end
end
