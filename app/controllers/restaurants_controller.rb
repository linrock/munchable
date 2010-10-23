class RestaurantsController < ApplicationController

  def index
    @restaurants = Restaurant.find(:all, :limit => 30)
    @categories = Category.all
  end

  def show
    id = params[:id]
    @restaurant = Restaurant.find(id)
    @comments = MenuComment.where(:restaurant_id => id)
    @coordinates = [@restaurant[:x], @restaurant[:y]]
  end
end
