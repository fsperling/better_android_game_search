class AddEmailAndWebpageToGame < ActiveRecord::Migration
  def change
    add_column :games, :email, :string
    add_column :games, :webpage, :string
  end
end
