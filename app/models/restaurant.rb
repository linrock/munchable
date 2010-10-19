class Restaurant < ActiveRecord::Base
  acts_as_commentable

  has_many :menu_items
end
