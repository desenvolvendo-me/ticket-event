class AddAvatarAndNameAndLoginToManagerUser < ActiveRecord::Migration[7.0]
  def change
    add_column :manager_users, :avatar_url, :string
    add_column :manager_users, :full_name, :string
    add_column :manager_users, :login, :string
  end
end
