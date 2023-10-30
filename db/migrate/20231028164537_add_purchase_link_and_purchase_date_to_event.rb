class AddPurchaseLinkAndPurchaseDateToEvent < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :purchase_link, :string
    add_column :events, :purchase_date, :datetime
  end
end
