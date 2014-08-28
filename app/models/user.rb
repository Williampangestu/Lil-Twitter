class User < ActiveRecord::Base
  has_many :tweets
  has_many :followers, through: :follower_follows, source: :follower
  has_many :follower_follows, foreign_key: :followee_id, class_name: "Follow"
  has_many :followees, through: :followee_follows, source: :followee
  has_many :followee_follows, foreign_key: :follower_id, class_name: "Follow"
end

# To determine a User’s :followees (upon an @user.followees call), Active Record may now look at each instance of class_name: “Follow” where such User is the the follower (i.e. foreign_key: :follower_id) through: such User’s :followee_follows. To determine a User’s :followers (upon an @user.followers call), Active Record may now look at each instance of class_name: “Follow” where such User is the the followee (i.e. foreign_key: :followee_id) through: such User’s :follower_follows.
