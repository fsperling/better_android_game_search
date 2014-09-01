class AddVersionToGame < ActiveRecord::Migration
  def change
    add_column :games, :version, :string
  end
end
