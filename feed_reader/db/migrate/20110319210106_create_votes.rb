class CreateVotes < ActiveRecord::Migration
  def self.up
    create_table :votes do |t|
      t.string :type
      t.integer :user_id, :entry_id, :null => false
      t.integer :rating
      t.timestamps
    end
  end

  def self.down
    drop_table :votes
  end
end
