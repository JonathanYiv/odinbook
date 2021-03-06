# Odinbook Project

This is [Odinbook](https://serene-coast-95388.herokuapp.com/).

Using this login will allow you to see the site with a seeded database.
```
username: JonathanYiv@gmail.com
password: password
```

The goal of this project is to implement Facebook -- without chat and AJAX -- in Rails.

This is a project from [The Odin Project](https://www.theodinproject.com/courses/ruby-on-rails/lessons/final-project).

Click the image below for a video demonstration of the features.

**Note:** This is created for a 2560x1440 screen. I have not developed strong responsive design skills yet, and viewing in a smaller screen may cause some UI issues.

[![Odinbook](/odinbook.png)](https://www.youtube.com/watch?v=CHI4sY1OLcw)

### Requirements

### Gems
* Uses [Better Errors](https://github.com/charliesome/better_errors) for debugging. ✔
* Uses [Guard](https://github.com/guard/guard) to run tests continuously. [✘](https://bountify.co/rspec-tests-fail-in-guard-but-manually-running-rspec-test-passes-why)[✘](https://stackoverflow.com/questions/24078768/argumenterror-factory-not-registered)
* Uses [FactoryBot](https://github.com/thoughtbot/factory_bot) in place of fixtures. ✔
* Uses [Materialize CSS](http://materializecss.com) as the CSS Framework. ✔

### Specifications
* Full test coverage with MiniTest.
* Uses PostgreSQL. ✔
* Deployed on Heroku. ✔
* Uses [Devise](https://github.com/plataformatec/devise) for authentication. ✔
* Uses [Omniauth](https://github.com/plataformatec/devise/wiki/OmniAuth:-Overview) to allow sign-in with Facebook.
* Mailer sends a welcome email after signup using [SendGrid](https://sendgrid.com). ✔
* Use [Faker](https://github.com/stympy/faker) to seed the database. ✔

### Features
* Users can send Friend Requests to other Users. ✔
* Users become friends when a Friend Request is accepted. ✔
* The Friend Request shows up as a notification in the navbar. ✔
* Users can create text or image Posts and upload profile pictures (using [Shrine](https://github.com/janko-m/shrine)). ✔
* Users can like Posts. ✔
* Users can comment on Posts. ✔
* Posts display with content, author, time, comments, and likes. ✔
* Comments display with content, author, time, and likes. ✔
* Logged in home page will have the 'Newsfeed.' ✔
* User's Show page has a Profile Page. ✔
* User Index page lists all users and Friend Request buttons. ✔

## Pre-Project Thoughts

### Models ✔
```ruby
All ✔
    *_id ✔
    created_at ✔
    updated_at ✔

User: ✔
    username: string ✔
    password: string ✔
    email: string ✔
    bio: text ✔
    birthday: date ✔
    
Post: ✔
    user_id: references ✔
    content: text ✔
    image_data: text ✔

Friendship: ✔
    requester_id: references ✔
    requested_id: references ✔
    accepted: boolean ✔

Comment: ✔
    user_id: references ✔
    post_id: references ✔
    content: text ✔

Like: ✔
    user_id: references ✔
    likeable_type: string ✔
    likeable_id: references ✔
```


### Associations ✔

```ruby
User ✔
    has_many :posts, dependent: :destroy ✔
    has_many :comments, dependent: :destroy ✔
    has_many :likes, dependent: :destroy ✔
    
    has_many :requested_friendships, foreign_key: requester_id, dependent: :destroy, -> { where accepted: true } ✔
    has_many :requesting_friendships, foreign_key: requested_id, dependent: :destroy, -> { where accepted: true } ✔
    has_many :requested_friends, through: :requested_friendships, source: :requested ✔
    has_many :requesting_friends, through: :requesting_friendships, source: :requester ✔
    
    # This is to delete any pending friendship requests
    has_many :friendship_requested, foreign_key: requester_id, dependent: :destroy ✔
    has_many :friendship_requests, foreign_key: requested_id, dependent: :destroy ✔

Post ✔
    belongs_to :user ✔
    has_many :likes, as :likeable ✔
    
Comment ✔
    belongs_to :post ✔
    belongs_to :user ✔
    has_many :likes, as: :likeable ✔

Like ✔
    belongs_to :likeable, polymorphic: true ✔
    belongs_to :user ✔

Friendships ✔
    belongs_to :requester, class_name: 'User', foreign_key: 'requester_id' ✔
    belongs_to :requested, class_name: 'User', foreign_key: 'requested_id' ✔
```
    
### Controllers
```ruby
StaticPages ✔
    home: The login/signup page, automatically redirected to if not logged in ✔
          If logged in, it is a timeline of all yours and your friend's posts ✔

User ✔
    index: Show the list of all users ✔
    show: Show the user's profile page ✔
    update: Update user's details ✔
    destroy: Delete a user ✔

Post ✔
    create: creates a new post ✔
    delete: deletes a post ✔

Comment ✔
    create: creates a new comment ✔
    delete: deletes a comment ✔

Like ✔
    create: creates a new like ✔
    destroy: deletes a like ✔

Friendship ✔
    index: Shows your current friend requests. ✔
    create: Creates a new friend requested ✔
    delete: Deletes an existing friend request or friendship ✔
```

## Post-Project Thoughts

1. Woo boy. That project took me a week. That was a long project.

2. I feel like I have levelled up in so many respects. Using gems, reading their documentation, integrating them into my Rails application, reading other guides/SO questions on particular reasons why it might not work, adding factories, writing cleaner code (still not great yet, more like a little less than good, but way better than before), deployment into the production environment with a bunch of configuration thingies. I just feel more powerful.

3. Not full test coverage yet. No integration tests. But this is the most test coverage I have ever done. I am starting to understand what to/what not to test. Onwards.
