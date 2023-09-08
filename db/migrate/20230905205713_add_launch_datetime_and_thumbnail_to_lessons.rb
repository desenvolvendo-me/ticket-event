class AddLaunchDatetimeAndThumbnailToLessons < ActiveRecord::Migration[7.0]
  def change
    add_column :lessons, :launch_datetime, :datetime
    add_column :lessons, :thumbnail, :string
  end
end
