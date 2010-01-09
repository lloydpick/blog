class RemoveUnusedFields < ActiveRecord::Migration
  def self.up
    remove_column :posts, :user_id
    remove_column :posts, :content_parsed
  end

  def self.down
    add_column :posts, :user_id, :integer
    add_column :posts, :content_parsed, :text
  end
end
