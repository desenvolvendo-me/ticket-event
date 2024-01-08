class RemoveSlugFromPrizeDraw < ActiveRecord::Migration[7.0]
  def change
    remove_column :prize_draws, :slug, :string
  end
end
