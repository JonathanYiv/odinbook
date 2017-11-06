class User < ApplicationRecord
  # Filters
  before_save :downcase_email

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

  # Validations
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 7, maximum: 40 }

  # Method to combine requested and requesting friends for all friends.
  def friends
    requested_friends + requesting_friends
  end

  private

    # Converts email to all lower-case
    def downcase_email
      email.downcase!
    end
end
