class AddEventToCertificates < ActiveRecord::Migration[7.0]
  def change
    add_reference :certificates, :event, null: false, foreign_key: true
  end
end
