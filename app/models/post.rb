class Post < ApplicationRecord
  # Default Scope
  default_scope { order(created_at: :desc) }

  # Associations
  belongs_to :user
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :comments, dependent: :destroy

  # Validations
  validates :content, presence: true, length: { maximum: 500 }
end
