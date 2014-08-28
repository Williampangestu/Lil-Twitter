class CreateFollows < ActiveRecord::Migration
  def change
    create_table :follows do |f|
      # f.belongs_to :user
      f.belongs_to :follower
      f.belongs_to :followee
      f.timestamps
    end
  end
end
