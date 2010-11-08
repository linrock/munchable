class LocationsController < ApplicationController

  def show
    @location = Location.find(params[:id])
    @categories = Category.all.collect {|c| c.name }
    
    respond_to do |format|
      format.js
    end
  end
end
