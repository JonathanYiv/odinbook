class AddUniquenessToFriendshipRequests < ActiveRecord::Migration[5.1]
  def change
    add_index :friendships, [:requested_id, :requester_id], unique: true
  end
end
