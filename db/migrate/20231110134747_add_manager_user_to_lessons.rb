class AddManagerUserToLessons < ActiveRecord::Migration[7.0]
  def change
    add_reference :lessons, :manager_user, null: false, foreign_key: true
  end
end
