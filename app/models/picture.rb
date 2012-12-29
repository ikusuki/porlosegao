class Picture < ActiveRecord::Base
  has_many :cards
  belongs_to :user, :counter_cache => true
end
