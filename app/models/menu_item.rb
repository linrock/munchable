class MenuItem < ActiveRecord::Base
  belongs_to :restaurant
  has_many :menu_comments
end
