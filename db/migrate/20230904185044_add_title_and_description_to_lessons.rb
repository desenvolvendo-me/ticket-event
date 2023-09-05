class AddTitleAndDescriptionToLessons < ActiveRecord::Migration[7.0]
  def change
    add_column :lessons, :title, :string
    add_column :lessons, :description, :text
  end
end
