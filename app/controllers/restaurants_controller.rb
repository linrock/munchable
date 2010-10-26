class RestaurantsController < ApplicationController

  def index

=begin
    @restaurants = []
    @categories = Category.all(:conditions => {:name => @categories})
    @categories.each {|c| @restaurants << c.restaurants }
    @restaurants = @restaurants.flatten.uniq
=end
    @restaurants = Location.where(:city => 'San Francisco').first.restaurants
    @categories = Category.all
  end

  def show
    id = params[:id]
    @restaurant = Restaurant.find(id)
    @comments = MenuComment.where(:restaurant_id => id)
    @coordinates = [@restaurant[:x], @restaurant[:y]]
  end
end
