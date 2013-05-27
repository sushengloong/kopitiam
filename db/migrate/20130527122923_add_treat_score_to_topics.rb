class AddTreatScoreToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :treat_score, :integer
  end
end
