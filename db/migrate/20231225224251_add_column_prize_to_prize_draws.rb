class AddColumnPrizeToPrizeDraws < ActiveRecord::Migration[7.0]
  def change
    add_column :prize_draws, :prize, :string
    add_column :prize_draws, :name, :string
    add_column :prize_draws, :date, :datetime
  end
end
