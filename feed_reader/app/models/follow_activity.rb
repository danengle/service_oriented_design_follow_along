class FollowActivity < Activity
  belongs_to :followed_user, :class_name => 'User'
end