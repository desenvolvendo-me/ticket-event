class AddProviderToManagerUser < ActiveRecord::Migration[7.0]
  def change
    add_column :manager_users, :provider, :string
  end
end
