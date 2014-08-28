class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |u|
      u.string :name, limit: 20
      u.string :password #bcrypt password_hash later
      u.timestamps
    end
  end
end
