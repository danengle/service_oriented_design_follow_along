class CreateActivities < ActiveRecord::Migration
  def self.up
    create_table :activities do |t|
      t.string :type
      t.integer :user_id, :feed_id, :followed_user_id, :following_user_id
      t.text :content
      t.timestamps
    end
  end

  def self.down
    drop_table :activities
  end
end
