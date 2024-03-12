class AddVisibilityFieldsToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :is_visible_to_registered_participants, :boolean, default: false
    add_column :events, :is_visible_after_time, :boolean, default: false
    add_column :events, :visible_after_time, :time
    add_column :events, :is_visible_during_event, :boolean, default: false
  end
end
