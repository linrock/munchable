class LocationsController < ApplicationController

  def show
    # @location = Location.find(params[:id])
    @location = Location.find(1)
    @categories = []
    # @location.restaurants.all(:select => 'categories').each do |r|

    Location.find(1).get_restaurants.all(:select => 'categories').each do |r|
      JSON.load(r.categories).each do |c|
        if not @categories.include? c
          @categories.push c
        end
      end
    end
    @categories = @categories.to_json
  end
end
