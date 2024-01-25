class AddColumnPrizeToPrizeDraws < ActiveRecord::Migration[7.0]
  def change
    create_table :prize_draws do |t|
      t.string :name
      t.string :prize
      t.datetime :date

      t.timestamps
    end
  end
end
