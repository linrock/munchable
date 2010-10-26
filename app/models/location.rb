class Location < ActiveRecord::Base
  has_many :restaurants

  @zone = "? > x_lower AND ? < x_upper AND ? > y_lower AND ? < y_upper"

  def self.get_location(x, y)
    self.where(@zone, x, x, y, y).first
  end
end
