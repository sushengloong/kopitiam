class AddThumbnailUrlToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :thumbnail_url, :string
  end
end
