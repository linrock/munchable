class RestaurantsController < ApplicationController

  def index
    serializer = ActiveSupport::JSON
    @restaurants = Restaurant.find(:all, :limit => 15)
    @restaurants_serialized = serializer.encode(@restaurants)
  end

  def show
    id = params[:id]
    @restaurant = Restaurant.find(id)
    @comments = MenuComment.where(:restaurant_id => id)
    @restaurant_serialized = ActiveSupport::JSON.encode([@restaurant])
    @coordinates = JSON.load @restaurant[:coordinates]
  end
end
