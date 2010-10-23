class Restaurant < ActiveRecord::Base
  has_many :menu_items
  has_many :menu_comments
  has_and_belongs_to_many :categories, :join_table => 'restaurants_categories'
end
