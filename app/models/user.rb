class User < ApplicationRecord
  # For Image Uploading
  include ImageUploader[:image]

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Add Omniauth Support for Facebook
  devise :omniauthable, omniauth_providers: [:facebook]

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

  # Additional Association for Logic Benefits
  has_many :unapproved_requesting_friends, through: :friendship_requests,
                                           source: :requester
  has_many :unapproved_requested_friends, through: :friendship_requested,
                                           source: :requested

  # Validations
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  # validates :password, presence: true, length: { minimum: 7, maximum: 40 }
  validates :first_name, presence: true, length: { minimum: 2, maximum: 40 }
  validates :last_name, presence: true, length: { minimum: 2, maximum: 40 }

  # Method to combine requested and requesting friends for all friends.
  def friends
    requested_friends + requesting_friends
  end

  # Method that returns true if the user is a friend
  def friend?(user)
    friends.include?(user)
  end

  # Method that combines first and last name
  def full_name
    "#{first_name} #{last_name}"
  end

  # Method that returns true if the user has a friend request from you 
  # or you have a friend request from them that is unaccepted
  def request?(user)
    unapproved_requested_friends.pluck(:id).include?(user.id) || unapproved_requesting_friends.pluck(:id).include?(user.id)
  end

  # Needs refactoring using associations
  # Method that returns the ID of the friendship request between two users
  def request_id(user)
    requester = Friendship.find_by(requester_id: self.id, requested_id: user.id)
    requested = Friendship.find_by(requester_id: user.id, requested_id: self.id)
    requester ? requester.id : requested.id
  end

  # Method that returns true if the user has any friend requests
  def has_requests
    friendship_requests.where(accepted: false).exists?
  end

  # Method that returns all friend requests to self
  def requests
    friendship_requests.where(accepted: false)
  end

  # Omniauth Method
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      #debugger
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.first_name = auth.info.name.to_s.split[0]
      user.last_name = auth.info.name.to_s.split[1]
    end
  end

  private

    # Converts email to all lower-case
    def downcase_email
      email.downcase!
    end
end
