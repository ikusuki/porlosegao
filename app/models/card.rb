class Card < ActiveRecord::Base
  belongs_to :picture,  :counter_cache => true
  belongs_to :user
  has_many :votes
  has_many :comments
  acts_as_taggable

  def set_tags(tags)
  	tag_list = tags
  	save
  end

  def add_tag(tag)
  	tag_list.add tag
  	save
  end

  def remove_tag(tag)
  	tag_list.remove tag
  	save
  end
end
