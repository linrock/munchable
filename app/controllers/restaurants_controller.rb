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
    max_num = 7
    if bounds != 'undefined'
      bounds = JSON.load bounds
      center = JSON.load params[:center]
      restaurants = Restaurant.get_nearest(bounds, center, params[:category], max_num)
    else
      l = Location.find(1)
      bounds = l.bounds
      center = [l.x_center, l.y_center]
      restaurants = Restaurant.get_nearest(bounds, center, params[:category], max_num)
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
