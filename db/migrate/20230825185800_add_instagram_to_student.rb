class AddInstagramToStudent < ActiveRecord::Migration[7.0]
  def change
    add_column :students, :username_instagram, :string
  end
end
