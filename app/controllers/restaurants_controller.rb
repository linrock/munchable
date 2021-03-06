class RestaurantsController < ApplicationController

  def show
    id = params[:id]
    @restaurant = Restaurant.find(id)
    @location = @restaurant.location
    @comments = MenuComment.where(:restaurant_id => id)
    @coordinates = [@restaurant[:x], @restaurant[:y]]
  end
  
  def instant
    max_num = 7
    if params[:bounds] #XXX - Need to fix parameter validation
      bounds = CGI.unescape(params[:bounds])
      bounds = JSON.load bounds
      center = JSON.load params[:center]
    else
      l = Location.find(params[:location_id])
      bounds = l.bounds
      center = [l.x_center, l.y_center]
    end
    @category = params[:category]
    if params[:search_type] == 'nearest'
      @restaurants = Restaurant.get_nearest(bounds, center, @category, max_num)
    elsif params[:search_type] == 'best'
      @restaurants = Restaurant.get_best(bounds, @category, max_num)
    else
      render :json => {}
    end
    @restaurants_clean = @restaurants.collect {|r|
      {
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
    }
    respond_to do |format|
      format.js
    end
  end

  def name_instant
    query = params[:q]
    # restaurants = Restaurant.where("name ILIKE ?", ["%#{query}%"]).order('rating DESC').limit(10)
    restaurants = Restaurant.tsearch(query).order('rating DESC').limit(10)
    render :json => {
      :restaurants => restaurants.collect do |r| {
          :id => r.id,
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
