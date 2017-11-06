class User < ApplicationRecord
  # Associations
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :requested_friendships, -> { where accepted: true },
                                    class_name: 'Friendship',
                                    foreign_key: 'requester_id',
                                    dependent: :destroy

  has_many :requesting_friendships, -> { where accepted: true },
                                    class_name: 'Friendship',
                                    foreign_key: 'requested_id',
                                    dependent: :destroy

  has_many :requested_friends, through: :requested_friendships,
                               source: :requested
  has_many :requesting_friends, through: :requesting_friendships,
                                source: :requester

  # Associations to delete any pending friendship requests
  has_many :friendship_requested, class_name: 'Friendship', 
                                  foreign_key: 'requester_id',
                                  dependent: :destroy
  has_many :friendship_requests, class_name: 'Friendship',
                                 foreign_key: 'requested_id',
                                 dependent: :destroy

  # Method to combine requested and requesting friends for all friends.
  def friends
    requested_friends + requesting_friends
  end
end
