class RenameRaffleToPrizeDraws < ActiveRecord::Migration[7.0]
  def change
    rename_table :raffles, :prize_draws
  end
end
