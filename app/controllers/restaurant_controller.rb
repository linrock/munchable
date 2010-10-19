class RestaurantController < ApplicationController
  def index
    serializer = ActiveSupport::JSON
    @restaurants = Restaurant.find(:all, :limit => "10")
    @restaurants_serialized = serializer.encode(@restaurants)
  end
end
