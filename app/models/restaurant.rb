class Restaurant < ActiveRecord::Base
  has_and_belongs_to_many :menu_items
  has_many :menu_comments
end
