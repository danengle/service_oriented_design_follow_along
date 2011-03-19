class Vote < ActiveRecord::Base
  validates_inclusion_of :value, :in => %w(up down)
  validates_uniqueness_of :user_id, :scope => :entry_id
  validates_presence_of :entry_id
  validates_presence_of :user_id
  
  scope :up, where(:value => 'up')
  scope :down, where(:value => 'down')
  scope :user_id, lambda {|user_id| where(:user_id => user_id)}
  scope :entry_id, lambda {|entry_id| where(:entry_id => entry_id)}
  
  class << self
    def create_or_update(attributes)
      vote = Vote.find_by_entry_id_and_user_id(attribute[:entry_id], attributes[:user_id])
      if vote.blank?
        Vote.create(attributes)
      else
        vote.value = attributes[:value]
        vote.save
        vote
      end
    end
  
    def voted_down_for_user_id(user_id, page, per_page = 25)
      entry_ids_for_user(user_id, 'down', page, per_page)
    end
    
    def voted_up_for_user_id(user_id, page, per_page = 25)
      entry_ids_for_user(user_id, 'up', page, per_page)
    end
    
    def entry_ids_for_user(user_id, value, page, per_page)
      votes = paginate_by_user_id_and_value(
        user_id, value, :page => page, :per_page => per_page)
      )
      votes.map {|vote| vote.entry_id }
    end
  end
end
