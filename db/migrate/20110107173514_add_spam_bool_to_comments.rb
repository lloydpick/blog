class AddSpamBoolToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :spam, :boolean, :default => true
  end

  def self.down
    remove_column :comments, :spam
  end
end
