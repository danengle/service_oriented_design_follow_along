class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  #has_many :follows
  #has_many :followed_users, :through => :follows
  #has_many :followings, :class_name => 'Follow', :foreign_key => :followed_user_id
  #has_many :followers, :through => :followings, :source => :user
  #has_many :comments
  #has_many :votes
  #has_many :subscriptions
  #has_many :feeds, :through :subscriptions
  #has_many :activities, :conditions => ["activities.following_user_id is null"]
  #has_many :followed_activities, :class_name => 'Activity', :foreign_key => :following_user_id
  
  
end
