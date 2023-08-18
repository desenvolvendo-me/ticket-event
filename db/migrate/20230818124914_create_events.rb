class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :description
      t.string :info

      t.timestamps
    end
  end
end
