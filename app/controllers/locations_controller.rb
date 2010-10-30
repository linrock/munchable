class LocationsController < ApplicationController

  def show
    @location = Location.find(params[:id])
    @categories = []
    Restaurant.within_bounds(@location.bounds).all(:select => 'categories').each do |r|
      JSON.load(r.categories).each do |c|
        if not @categories.include? c
          @categories.push c
        end
      end
    end
    @categories = @categories.to_json

    # @categories = Category.all.collect {|c| c.name }
  end
end
