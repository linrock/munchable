class LocationsController < ApplicationController

  def show
    # @location = Location.find(params[:id])
    @location = Location.find(1)
    @categories = []
    # @location.restaurants.all(:select => 'categories').each do |r|

    Restaurant.where("xy && ?", Polygon.from_coordinates([[
      [37.6946877, -122.5344078],
      [37.8116826, -122.5344078],
      [37.8116826, -122.3550796],
      [37.6946877, -122.3550796],
      [37.6946877, -122.5344078]
    ]], 4326)).all(:select => 'categories').each do |r|
      JSON.load(r.categories).each do |c|
        if not @categories.include? c
          @categories.push c
        end
      end
    end
    @categories = @categories.to_json
  end
end
