class AdjustPostContentType < ActiveRecord::Migration
  def self.up
    change_column :posts, :content, :text
  end

  def self.down
    change_column :posts, :content, :string
  end
end
