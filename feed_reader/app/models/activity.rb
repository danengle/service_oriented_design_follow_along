class Activity < ActiveRecord::Base
  belongs_to :user
  
  def self.write(event)
    create(event.attributes)
    event.user.followers.each do |user|
      create(event.attributes.merge(:following_user_id => user.id))
    end
  end
end
