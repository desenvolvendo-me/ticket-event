class AddDateAndLaunchToEvents < ActiveRecord::Migration[7.0]
  def change
    rename_column :events, :info, :date
    change_column :events, :date, "timestamp without time zone USING date::timestamp without time zone"
    add_column :events, :launch, :integer
  end
end
