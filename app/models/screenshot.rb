class Screenshot < ActiveRecord::Base
  belongs_to :game
  #validates :game_id, presence: true
  validates :url, presence: true, length: { maximum: 300 }, :url => true
end
