class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.references :topic, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
