class List < ActiveRecord::Base
  belongs_to :group
  has_many :restaurants
  has_many :restaurant_comments
end
