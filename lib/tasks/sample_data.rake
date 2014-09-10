namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_microposts
    make_relationships
    make_categories
    make_games
    make_categorizations
    make_screenshots
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
    description = Faker::Lorem.paragraph
    version = Faker::App.version
    email = Faker::Internet.email
    webpage = Faker::Internet.url
    banner_image_url = "http://lh4.ggpht.com/j19PDvSV8SoM7FwnXrNqx4PgfpBijHrmpQ0IYp6eOyp06ZqtmVaXa1HyGgb3eCtQ8HE=w400"
    banner_icon_url = "http://lh4.ggpht.com/j19PDvSV8SoM7FwnXrNqx4PgfpBijHrmpQ0IYp6eOyp06ZqtmVaXa1HyGgb3eCtQ8HE=w200"
    Game.create!(name: name, description: description, version: version, email: email, webpage: webpage,
            banner_image_url: banner_image_url, banner_icon_url: banner_icon_url)
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

def make_screenshots
  example_screenshot_urls = ["https://lh6.ggpht.com/ozfPBInQ1ryiKwNN1W6rH2XilCXHLB2seCRdbLf9ooFbuNVzsi79l8XLizila3-_NkI=h310","https://lh5.ggpht.com/36UGtE32jMR-VpidQqzC8y8m6PQZ0tooeIR0LsgJ91uU9dkqbcDoRXW-DLaogfmQ1g=h310","https://lh3.ggpht.com/Za-PsmD2XanmzoD_OXRMNH2uoeLSunz5vakCRrANz3TQfobIaVfi9nIdE9sOXAfXkg=h310","https://lh6.ggpht.com/AtcTKsu2ksDgPoq1Z5V_ZOA_8iXV9mltzi9RtnaEujhYhdW-kMV2IY-F9y2pSS__aoU=h310","https://lh6.ggpht.com/4tx4gOXPG2d20L0Aeh3tQCRUhU4W6Y1adNGD1tnz4nwTCkmjfn9zkGHtaDo5HvSCEg=h310","https://lh5.ggpht.com/Q5b3CxtBEodvggO7vaqdD5ci2S1QWxX3Zib2fOaII02GDREOFDqPpmYX1_T5cBi8_qJD=h310","https://lh5.ggpht.com/YhvB1q13TOBmGrDFMvEOjhYvu_bJYyfA_X8RzCxD8NqoSIrcXs5uQC7-47waye36u9o=h310","https://lh5.ggpht.com/fHBTmasJ7DXrLuN--x3cBt7-KAYTs9Rn8yDU2_AsWktIkMtY1j31EUSHeNsNuQYFGgc=h310","https://lh3.ggpht.com/HmzjIboCzOA7nDysaepgnjfuRV6K7KZ5uXbsCPn3Aos3Af-WGuQdRVS8BSEQKI8ywg=h310","https://lh5.ggpht.com/_RnJy2pUWWF7gz1w1voN0k12zS1AteqgFDq79VegEY-cw5Jbn1nfB9f3CrSSHhX1dX4=h310","https://lh6.ggpht.com/jPoRKGb1kyFY5L8eUTKnD4CS_NYgP34MvVmSziFrMl7yE6sPcUJhsXpFe36dWE1WFw=h310","https://lh4.ggpht.com/Wq83X2ruj9Ti5ZVmL6d1MdmvhQcPqbsJfXZODOVWGQs7vUO1gr9znqF7qfJ2Y1X1WA=h310","https://lh6.ggpht.com/jXxGkjByJmomCI1gHi8Ri3QFo6WHOYGgZUuG-fPipBfaOhUJPijkXOdX54Zu2KDM8MU=h310","https://lh5.ggpht.com/VSQL_mkKM76lM7NQFlwZYjR9l24Gwrrscfc1vipchcxYjiqdTofBNTJ2uu2fyOplyMM=h310","https://lh3.ggpht.com/sxP93HCETVIlTB9IngafnPHAQhRTnJCH4RpjQPz9UcY6I-UfuNrmER12DpOmz_usuOs=h310"]
  games = Game.all(limit: 10)
  games.each do |game|
    5.times do
      url = example_screenshot_urls.sample
      game.screenshots.create!(url: url)
    end
  end
end