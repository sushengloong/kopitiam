class CreateTreats < ActiveRecord::Migration
  def change
    create_table :treats do |t|
      t.string :name
      t.integer :value
      t.references :user, index: true
      t.references :topic, index: true

      t.timestamps
    end
  end
end
