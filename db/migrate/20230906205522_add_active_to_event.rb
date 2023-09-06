class AddActiveToEvent < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :active, :boolean, default: true
  end
end
