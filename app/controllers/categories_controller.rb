class CategoriesController < ApplicationController

  def show
    @location = Location.find(params[:location_id])
    @category = Category.find(params[:id])
    @restaurants = @category.restaurants.where(:location_id => @location.id)
  end
end
