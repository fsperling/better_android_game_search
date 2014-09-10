FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end
  
  factory :micropost do
    content "Lorem ipsum"
    user
  end  
  
  factory :game do
    name "Unreal"
    description "alien ego shooter"
    version "v1.0"
    email "bla@asdf.com"
    webpage "http://www.asdf.com/asd"
    banner_icon_url "http://lh4.ggpht.com/j19PDvSV8SoM7FwnXrNqx4PgfpBijHrmpQ0IYp6eOyp06ZqtmVaXa1HyGgb3eCtQ8HE=w200"
    banner_image_url "https://lh4.ggpht.com/j19PDvSV8SoM7FwnXrNqx4PgfpBijHrmpQ0IYp6eOyp06ZqtmVaXa1HyGgb3eCtQ8HE=w400"
    
#    factory :game_with_categories do
#      transient do
#        categories_count 3
#      end
#      
#      after(:create) do |game, evaluator|
#        create_list(:category, evaluator.categories_count, game: game)
#      end
#    end
  end
  
  factory :category do
    sequence(:name) { |n| "fg-category-#{n}" }
  end

  factory :screenshot do
    url "http://lh4.ggpht.com/j19PDvSV8SoM7FwnXrNqx4PgfpBijHrmpQ0IYp6eOyp06ZqtmVaXa1HyGgb3eCtQ8HE=w200"
    game
  end

end