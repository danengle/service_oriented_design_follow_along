class CreateEntries < ActiveRecord::Migration
  def self.up
    create_table :entries do |t|
      t.integer :feed_id
      t.string :title, :url
      t.text :content
      t.datetime :published_date
      t.integer :up_votes_count, :down_votes_count, :comments_count
      t.timestamps
    end
  end

  def self.down
    drop_table :entries
  end
end
