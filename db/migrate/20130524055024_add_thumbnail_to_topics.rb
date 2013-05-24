class AddThumbnailToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :thumbnail, :string
  end
end
