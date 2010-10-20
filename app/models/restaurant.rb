class Restaurant < ActiveRecord::Base
  has_many :menu_items
  has_many :menu_comments
end
