# == Schema Information
# Schema version: 20090422233019
#
# Table name: comments
#
#  id           :integer         not null, primary key
#  post_id      :integer
#  author       :string(255)
#  user_ip      :string(255)
#  author_url   :string(255)
#  author_email :string(255)
#  content      :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#  deleted_at   :datetime
#  user_agent   :string(500)
#

class Comment < ActiveRecord::Base

  include Rakismet::Model
  attr_accessor :referrer
  belongs_to :post

  validates :author, :presence => true
  validates :content, :presence => true
  validates :post_id, :presence => true, :numericality => true

  scope :not_spam, :conditions => { :spam => false }
  scope :active, :conditions => [ "deleted_at IS NULL" ]
  scope :order, :order => "created_at DESC"
  scope :limit, lambda {
    |num| { :limit => num }
  }
  
end
