class AddUidAndAvatarUrlToManagerUser < ActiveRecord::Migration[7.0]
  def change
    add_column :manager_users, :uid, :string
    add_column :manager_users, :avatar_url, :string
  end
end
