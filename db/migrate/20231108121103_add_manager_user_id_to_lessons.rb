class AddManagerUserIdToLessons < ActiveRecord::Migration[7.0]
  def change
    add_column :lessons, :manager_user_id, :integer
  end
end
