class Category < ActiveRecord::Base
  before_save { name.downcase! }
  
  has_many :game_categorizations, dependent: :destroy
  has_many :games, through: :game_categorizations
  
  validates :name, uniqueness: { case_sensitive: false }, presence: true, length: { maximum: 50 }
end
