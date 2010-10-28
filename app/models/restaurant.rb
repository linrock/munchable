class Restaurant < ActiveRecord::Base
  has_many :menu_items
  has_many :menu_comments
  belongs_to :location
end
