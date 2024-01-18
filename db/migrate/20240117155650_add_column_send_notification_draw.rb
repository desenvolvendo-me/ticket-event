class AddColumnSendNotificationDraw < ActiveRecord::Migration[7.0]
  def change
    add_column :prize_draws, :ticket_email,:string
  end
end
