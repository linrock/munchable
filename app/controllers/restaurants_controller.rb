class RestaurantsController < ApplicationController

  def show
    id = params[:id]
    @restaurant = Restaurant.find(id)
    @location = @restaurant.location
    @comments = MenuComment.where(:restaurant_id => id)
    @coordinates = [@restaurant[:x], @restaurant[:y]]
  end
  
  def instant
    categories = Category.where(:name => CGI.unescape(params[:category])).first.restaurants.where(:location_id => params[:location_id])
    render :json => { :restaurants => categories.collect{|c| {:name => c.name, :address => c.address, :hours => c.hours, :rating => c.rating, :x => c.x, :y => c.y} }}
  end
end
