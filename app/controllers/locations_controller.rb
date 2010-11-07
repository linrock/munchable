class LocationsController < ApplicationController

  def show
    @location = Location.find(params[:id])
    @categories = Category.all.collect {|c| c.name }
  end
end
