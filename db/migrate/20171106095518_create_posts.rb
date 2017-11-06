class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.references :user, foreign_key: true
      t.text :content
      t.text :image_data

      t.timestamps
    end
  end
end
