class LocationsController < ApplicationController

  def show
    @location = Location.find(params[:id])
    @categories = []
    @location.restaurants.each do |r|
      r.categories.each do |c|
        if not @categories.include? c.name
          @categories.push c.name
        end
      end
    end
    @categories = @categories.to_json
  end
end
