# == Schema Information
# Schema version: 20090404170416
#
# Table name: tags
#
#  id          :integer         not null, primary key
#  name        :string(50)
#  permalink   :string(50)
#  description :string(300)
#  created_at  :datetime
#  updated_at  :datetime
#

class Tag < ActiveRecord::Base

  # Associations
  acts_as_slugable :source_column => :name, :slug_column => :permalink
  has_many :tag_entry
  has_many :posts, :through => :tag_entry

  # Validations
  validates_presence_of :name, :description
  validates_uniqueness_of :name, :permalink

  named_scope :all, {
    :order => "name DESC"
  }

  # Over-rides
  def to_param
    permalink
  end

end
