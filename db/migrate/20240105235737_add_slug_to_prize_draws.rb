class AddSlugToPrizeDraws < ActiveRecord::Migration[7.0]
  def change
    add_column :prize_draws, :slug, :string
    add_index :prize_draws, :slug, unique: true, name: 'index_prize_draws_on_slug'
  end
end
