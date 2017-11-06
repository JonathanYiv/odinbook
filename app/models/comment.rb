class Comment < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :post
  has_many :likes, as: :likeable
end
