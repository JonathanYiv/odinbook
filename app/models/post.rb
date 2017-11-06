class Post < ApplicationRecord
  # Associations
  belongs_to :user
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :comments, dependent: :destroy
end
