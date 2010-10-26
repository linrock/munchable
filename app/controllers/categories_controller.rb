class CategoriesController < ApplicationController

  def show
    @location = Location.find(params[:location_id])
    @category = Category.find(params[:id])
  end
end
