class Game < ActiveRecord::Base
   has_many :game_categorizations, dependent: :destroy
   has_many :categories, through: :game_categorizations
  
   validates :name, presence: true, length: { maximum: 50 }
   validates :description, presence: true

   def assign_category!(category) 
     game_categorizations.create!(category_id: category.id)
   end
   
   def category?(category)
     game_categorizations.find_by(category_id: category.id)
   end
   
   def remove_from_category!(category)
     game_categorizations.find_by(category_id: category.id).destroy
   end
end
