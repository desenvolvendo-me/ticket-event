class CreateRaffles < ActiveRecord::Migration[7.0]
  def change
    create_table :raffles do |t|
      t.references :event, null: false, foreign_key: true
      t.references :winner, null: false, foreign_key: { to_table: :students }

      t.timestamps
    end
  end
end
