# Creates my Master Account
super_user = User.create!(email:      "JonathanYiv@gmail.com",
                          password:   "password",
                          bio:        "I am the Dragon",
                          first_name: "Jonathan",
                          last_name:  "Yiv")

# Create 50 Seed Accounts
50.times do |n|
  email       = Faker::Internet.email
  password    = "password"
  bio         = Faker::Lorem.sentence
  first_name  = Faker::Name.first_name
  last_name   = Faker::Name.last_name

  User.create!(email:      email,
               password:   password,
               bio:        bio,
               first_name: first_name,
               last_name:  last_name)
end

# Grabs all the Users
users = User.where.not(id: super_user.id).all

# All users establish friendships with my master account
users.each do |user|
  accepted = [true, true, false].sample
  Friendship.create(requester: user,
                    requested: super_user,
                    accepted:  accepted)
end

# Grabs the 10 last created users
recent_users = users.order(created_at: :desc).take(10)

# Creates 10 Posts for each of these users
recent_users.each do |user|
  10.times do
    content = Faker::Lorem.sentences(2).join(" ")
    user.posts.create!(content: content)
  end
end

# Grabs the 40 other users
other_users = users.order(created_at: :asc).take(40)

# Creates 5 Posts for the remaining users
other_users.each do |user|
  5.times do
    content = Faker::Lorem.sentences(2).join(" ")
    user.posts.create!(content: content)
  end
end

# Grab all the posts
posts = Post.all

# Grab the 50 most recent posts
recent_posts = posts.order(created_at: :desc).take(50)

# Use each recent user to randomly add 10 comments randomly selected recent posts
recent_users.each do |user|
  10.times do
    post    = recent_posts.sample
    content = Faker::Lorem.sentences(1).join
    user.comments.create!(user:    user,
                          post:    post,
                          content: content)
  end
end

# Grab all the comments
comments = Comment.all

# Grab the 50 most recent comments
recent_comments = comments.order(created_at: :desc).take(50)

# Use each recent user to randomly like 20 comments or posts 
# from randomly selected recent posts/comments
recent_users.each do |user|
  20.times do |n|
    if n % 2 == 0
      likeable = recent_comments.sample
      recent_comments.delete(likeable)
    else
      likeable = recent_posts.sample
      recent_posts.delete(likeable)
    end
    user.likes.create!(likeable: likeable)
  end
  recent_posts = posts.order(created_at: :desc).take(50)
  recent_comments = comments.order(created_at: :desc).take(50)
end

# Create random friendships between users
users.each do |user|
  all_users = User.where.not(id: super_user.id).all.to_a
  friends = Random.rand(50)
  friends.times do
    accepted = [true, true, true, false].sample
    friend = all_users.sample
    all_users.delete(friend)
    Friendship.create!(requester:  user,
                      requested:  friend,
                      accepted:   accepted)
  end 
end