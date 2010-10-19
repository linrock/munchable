class RestaurantsController < ApplicationController

  def index
    serializer = ActiveSupport::JSON
    @restaurants = Restaurant.find(:all, :limit => "10")
    @restaurants_serialized = serializer.encode(@restaurants)
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @restaurant_serialized = ActiveSupport::JSON.encode([@restaurant])
    @coordinates = JSON.load @restaurant[:coordinates]
  end
end
