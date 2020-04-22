class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  acts_as_followable
  acts_as_follower

  has_many :tweets, dependent: :destroy
  scope :all_except, ->(user) { where.not(id: user) }

  def full_name
    self.first_name + ' ' + self.last_name
  end

  def following
    self.all_following
  end

  def followers
    self.all_follows  
  end

  def profile_data
    {
      first_name: first_name,
      last_name: last_name,
      email: email,
      followings: following,
      followers: followers  
    }
  end
end
