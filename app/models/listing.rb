class Listing < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :list
end
