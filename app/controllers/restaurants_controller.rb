class RestaurantsController < ApplicationController

  def index
    # @restaurants = Restaurant.find(:all, :limit => 50)

=begin
    @restaurants = []
    @categories = Category.all(:conditions => {:name => @categories})
    @categories.each {|c| @restaurants << c.restaurants }
    @restaurants = @restaurants.flatten.uniq
=end
    @categories = Category.all
    # @restaurants = Restaurant.all
    @restaurants = Restaurant.where(@zone, 37.6946877, 37.8116826, -122.5233078, -122.3550796).all
    # @restaurants = Restaurant.where(zone, 37.383116, 37.395221, -122.091879, -122.070637).all
  end

  def show
    id = params[:id]
    @restaurant = Restaurant.find(id)
    @comments = MenuComment.where(:restaurant_id => id)
    @coordinates = [@restaurant[:x], @restaurant[:y]]
  end
end
