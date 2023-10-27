class AddCommunityLinkToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :community_link, :string
  end
end
