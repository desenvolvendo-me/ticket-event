class AddDurationToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :duration, :integer
  end
end
