class YelpController < ApplicationController
  def index
    serializer = ActiveSupport::JSON
    @restaurants = Yelp.find(:all, :limit => "10")
    @restaurants_serialized = serializer.encode(@restaurants)
  end
end
