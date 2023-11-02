class AddProfileSocialToStudent < ActiveRecord::Migration[7.0]
  def change
    add_column :students, :profile_social, :string
    add_column :students, :type_social, :string
  end
end
