class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :entry, :count_cache => true
  
  after_create {|record| CommentActivity.write(record) }
end
