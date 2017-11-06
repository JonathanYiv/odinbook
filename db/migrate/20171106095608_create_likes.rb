class CreateLikes < ActiveRecord::Migration[5.1]
  def change
    create_table :likes do |t|
      t.references :user, foreign_key: true
      t.string :likeable_type
      t.integer :likeable_id

      t.timestamps
    end
    add_index :likes, :likeable_id
  end
end
