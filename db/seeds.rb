# Creates my Master Account
super_user = User.create!(email: "JonathanYiv@gmail.com",
                          password: "password",
                          bio: "I am the Dragon",
                          first_name: "Jonathan",
                          last_name: "Yiv")

# Create 100 Seed Accounts
100.times do |n|
  email       = Faker::Internet.email
  password    = "password"
  bio         = Faker::Lorem.sentence
  first_name  = Faker::Name.first_name
  last_name   = Faker::Name.last_name

  User.create!(email:      email,
               password:   password,
               bio:        bio,
               first_name: first_name,
               last_name: last_name)
end

# Grabs all the Users
users = User.all

# All users establish friendships with my master account
users.each do |user|
  Friendship.create(requester: user,
                    requested: super_user,
                    accepted: true)
end

# Grabs the 10 last created users
recent_users = users.order(created_at: :desc).take(10)

# Creates 50 Posts for each of these users
50.times do
  content = Faker::Lorem.sentences(2).join(" ")
  users.each { |user| user.posts.create!(content: content) }
end

# Grabs the 90 other users
other_users = users.order(created_at: :asc).take(90)

# Creates 5 Posts for the remaining users
5.times do
  content = Faker::Lorem.sentences(2).join(" ")
  users.each { |user| user.posts.create!(content: content) }
end

# Need to create comments, likes, friendship requests, and friendships