class LocationsController < ApplicationController

  def show
    @location = Location.find(params[:id])
    @restaurants = @location.restaurants
    @category = {
      :counts => {},
      :ids => {}
    }
    @restaurants.each do |r|
      r.categories.each do |c|
        @category[:counts][c.name] = @category[:counts][c.name].nil? ? 1 : @category[:counts][c.name] + 1
        @category[:ids][c.name] = c.id
      end
      if r.good_for > ""
        r.good_for = JSON.load(r.good_for).join ', '
      end
    end
  end
end
