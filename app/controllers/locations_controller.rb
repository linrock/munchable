class LocationsController < ApplicationController

  def show
    @location = Location.find(params[:id])
    @restaurants = @location.restaurants
    @category_counts = {}
    @restaurants.each do |r|
      r.categories.each do |c|
        @category_counts[c.name] = @category_counts[c.name].nil? ? 1 : @category_counts[c.name] + 1
      end
    end
  end
end
