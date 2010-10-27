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
    end
    @categories = Category.all.collect{|c| c.name }.to_json
    @restaurants_serialized = @restaurants.collect do |r| {
        :name => r.name,
        :address => r.address,
        :hours => r.hours,
        :rating => r.rating,
        :x => r.x,
        :y => r.y 
      }.to_json
    end
  end
end
