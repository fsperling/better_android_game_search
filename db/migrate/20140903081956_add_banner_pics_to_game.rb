class AddBannerPicsToGame < ActiveRecord::Migration
  def change
    add_column :games, :banner_icon_url, :string
    add_column :games, :banner_image_url, :string
  end
end
