class Post < ApplicationRecord
  # Associations
  belongs_to :user
  has_many :likes, as: :likeable
end
