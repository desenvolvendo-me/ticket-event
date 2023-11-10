class RemoveManagerUserIdFromLessons < ActiveRecord::Migration[7.0]
  def change
    remove_column :lessons, :manager_user_id, :integer
  end
end
