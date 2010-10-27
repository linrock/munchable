class CategoriesController < ApplicationController

  def show
    @location = Location.find(params[:location_id])
    @category = Category.find(params[:id])
    @restaurants = @category.restaurants.where(:location_id => @location.id)
  end

  def autocomplete
    categories = Category.search(:name_starts_with => params[:query])
    render :json => { :query => params[:query], :categories => categories.relation.collect{|c| c.name} }
  end
end
