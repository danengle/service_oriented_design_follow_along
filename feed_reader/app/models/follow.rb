class Follow < ActiveRecord::Base
  belongs_to :user
  belongs_to :followed_user, :class_name => 'User'
  after_create {|record| FollowActivity.write(record) }
end
