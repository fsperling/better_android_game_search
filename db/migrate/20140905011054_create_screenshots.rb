class CreateScreenshots < ActiveRecord::Migration
  def change
    create_table :screenshots do |t|
      t.string :url
      t.integer :game_id

      t.timestamps
    end
    add_index :screenshots, [:game_id, :created_at]
  end
end
