class List < ActiveRecord::Base
  belongs_to :user, :through => :groups
  has_many :restaurants, :through => :listings
end
