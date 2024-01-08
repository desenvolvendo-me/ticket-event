class AddColumnWinnerToPrizeDraws < ActiveRecord::Migration[7.0]
  def change
    add_column :prize_draws, :winner, :string
  end
end
