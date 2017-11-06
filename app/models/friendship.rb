class Friendship < ApplicationRecord
  # Associations
  belongs_to :requester, class_name: 'User', foreign_key: 'requester_id'
  belongs_to :requested, class_name: 'User', foreign_key: 'requested_id'
end
