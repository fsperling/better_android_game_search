namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_microposts
    make_relationships
    make_categories
    make_games
    make_categorizations
  end
end

def make_users
  admin = User.create!(name:     "Example User",
                       email:    "example@railstutorial.org",
                       password: "foobar",
                       password_confirmation: "foobar",
                       admin: true)
  99.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password  = "password"
    User.create!(name:     name,
                 email:    email,
                 password: password,
                 password_confirmation: password)
  end
end

def make_categories
  10.times do |n|
    name = "category-#{n+1}"
    Category.create(name: name)
  end
end

def make_games
  20.times do |n|
    name = Faker::App.name
    description = Faker::Company.catch_phrase
    version = Faker::App.version
    email = Faker::Internet.email
    webpage = Faker::Internet.url
    Game.create!(name: name, description: description, version: version, email: email, webpage: webpage)
  end
end

def make_categorizations
  games = Game.all
  categories = Category.all
  20.times do |n|
    games[n].assign_category!(categories[n%10])
  end
  5.times do |n|
    games[n].assign_category!(categories[n+1])
  end
end

def make_microposts
  users = User.all(limit: 6)
  50.times do
    content = Faker::Lorem.sentence(5)
    users.each { |user| user.microposts.create!(content: content) }
  end
end


def make_relationships
  users = User.all
  user  = users.first
  followed_users = users[2..50]
  followers      = users[3..40]
  followed_users.each { |followed| user.follow!(followed) }
  followers.each      { |follower| follower.follow!(user) }
end