class MenuItem < ActiveRecord::Base
  has_and_belongs_to_many :restaurants
  has_many :menu_comments
end
