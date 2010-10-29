class Location < ActiveRecord::Base
  has_many :restaurants

  @zone = "? > x_lower AND ? < x_upper AND ? > y_lower AND ? < y_upper"

  def self.get_location(x, y)
    self.where(@zone, x, x, y, y).first
  end

  def get_restaurants
    Restaurant.where("xy && ?", Polygon.from_coordinates([[
      [x_lower, y_lower],
      [x_upper, y_lower],
      [x_upper, y_upper],
      [x_upper, y_upper],
      [x_lower, y_lower]
    ]], 4326))
  end
end
