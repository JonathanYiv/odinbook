class CreateFriendships < ActiveRecord::Migration[5.1]
  def change
    create_table :friendships do |t|
      t.integer :requester_id
      t.integer :requested_id
      t.boolean :accepted

      t.timestamps
    end
    add_index :friendships, [:requester_id, :requested_id]
  end
end
