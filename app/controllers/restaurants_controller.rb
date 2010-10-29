class RestaurantsController < ApplicationController

  def show
    id = params[:id]
    @restaurant = Restaurant.find(id)
    @location = @restaurant.location
    @comments = MenuComment.where(:restaurant_id => id)
    @coordinates = [@restaurant[:x], @restaurant[:y]]
  end
  
  def instant
    bounds = CGI.unescape(params[:bounds])
    if bounds != 'undefined'
      bounds = JSON.load bounds
      restaurants = Restaurant
        .where('xy && ?', Polygon.from_coordinates([[
          [bounds['x'][0], bounds['y'][0]],
          [bounds['x'][1], bounds['y'][0]],
          [bounds['x'][1], bounds['y'][1]],
          [bounds['x'][0], bounds['y'][1]],
          [bounds['x'][0], bounds['y'][0]]
        ]], 4326))
        .search(:categories_contains => CGI.unescape(params[:category]))
        .all(:order => 'rating DESC', :limit => 7)
        .sort_by {|c| [c[:rating], c[:review_count]]}.reverse
    else
      restaurants = Location.find(params[:location_id]).restaurants
        .search(:categories_contains => CGI.unescape(params[:category]))
        .all(:order => 'rating DESC', :limit => 7)
        .sort_by {|c| [c[:rating], c[:review_count]]}.reverse
    end
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
          :x => r.xy.x,
          :y => r.xy.y
        }
      end
    }
  end
end
