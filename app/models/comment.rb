class Comment < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :post
  has_many :likes, as: :likeable, dependent: :destroy

  # Validations
  validates :content, presence: true, length: { maximum: 250 }
end
