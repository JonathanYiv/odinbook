class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :password
      t.string :email
      t.text :bio
      t.date :birthday

      t.timestamps
    end
  end
end
