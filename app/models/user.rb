class User < ActiveRecord::Base
  validates :name, uniqueness: true
  has_many :tweets
  has_many :followers, through: :follower_follows, source: :follower
  has_many :follower_follows, foreign_key: :followee_id, class_name: "Follow"
  has_many :followees, through: :followee_follows, source: :followee
  has_many :followee_follows, foreign_key: :follower_id, class_name: "Follow"

  def self.exist?(name, password)
    User.find_by(name: name).password == password
  end
end
