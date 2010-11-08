class Comment < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :user
  belongs_to :list
end
