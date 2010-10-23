class RestaurantsController < ApplicationController

  def index
    # @restaurants = Restaurant.find(:all, :limit => 50)
    # @categories = Category.all

    @restaurants = []
    categories = [
      'bakeries',
      'desserts',
      'bars',
      'food stands',
      'breakfast & brunch',
      'coffee & tea',
      'sandwiches',
      'pizza',
      'american (traditional)',
      'delis',
      'burgers',
      'seafood',
      'diners',
    ]
    @categories = Category.all(:conditions => {:name => categories})
    @categories.each {|c| @restaurants << c.restaurants }
    @restaurants.flatten!
  end

  def show
    id = params[:id]
    @restaurant = Restaurant.find(id)
    @comments = MenuComment.where(:restaurant_id => id)
    @coordinates = [@restaurant[:x], @restaurant[:y]]
  end
end
