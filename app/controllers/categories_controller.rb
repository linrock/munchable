class CategoriesController < ApplicationController

  def show
    @location = Location.where(:city => 'San Francisco').first
    @category = Category.find(params[:id])
  end
end
