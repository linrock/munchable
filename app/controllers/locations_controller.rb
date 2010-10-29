class LocationsController < ApplicationController

  def show
    # @location = Location.find(params[:id])
    @location = Location.find(1)
    @categories = []
    # @location.restaurants.all(:select => 'categories').each do |r|

    bounds = Location.find(1).bounds
    Restaurant.within_bounds(bounds).all(:select => 'categories').each do |r|
      JSON.load(r.categories).each do |c|
        if not @categories.include? c
          @categories.push c
        end
      end
    end
    @categories = @categories.to_json
  end
end
