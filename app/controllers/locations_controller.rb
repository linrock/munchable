class LocationsController < ApplicationController

  def show
    @location = Location.find(params[:id])
    @restaurants = @location.restaurants
    @categories = Category.all
  end
end
