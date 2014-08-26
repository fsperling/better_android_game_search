class CreateGameCategorizations < ActiveRecord::Migration
  def change
    create_table :game_categorizations do |t|
      t.integer :game_id
      t.integer :category_id

      t.timestamps
    end
  end
end
