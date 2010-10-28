class RestaurantsController < ApplicationController

  def show
    id = params[:id]
    @restaurant = Restaurant.find(id)
    @location = @restaurant.location
    @comments = MenuComment.where(:restaurant_id => id)
    @coordinates = [@restaurant[:x], @restaurant[:y]]
  end
  
  def instant
    restaurants = Location.find(params[:location_id]).restaurants
      .search(:categories_contains => CGI.unescape(params[:category]))
      .all(:order => 'rating DESC', :limit => 7)
      .sort_by {|c| [c[:rating], c[:review_count]]}.reverse
    render :json => {
      :restaurants => restaurants.collect do |r| {
          :name => r.name,
          :address => r.address,
          :hours => r.hours,
          :website => r.website,
          :rating => r.rating,
          :review_count => r.review_count,
          :take_out => r.take_out,
          :delivery => r.delivery,
          :x => r.x,
          :y => r.y
        }
      end
    }
  end
end
