class Card < ActiveRecord::Base
  belongs_to :picture,  :counter_cache => true
  belongs_to :user
  has_many :votes
end
