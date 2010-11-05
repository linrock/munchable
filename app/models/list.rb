class List < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  has_many :listings, :dependent => :destroy
  has_many :restaurants, :through => :listings
end
