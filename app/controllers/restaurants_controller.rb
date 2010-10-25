class RestaurantsController < ApplicationController

  def index
    # @restaurants = Restaurant.find(:all, :limit => 50)
    # @categories = Category.all

    @restaurants = []
    categories = [
      'mexican',
      'bakeries',
      'desserts',
      'ice cream & frozen yogurt',
      'sandwiches',
      'food stands',
      'breakfast & brunch',
      'coffee & tea',
      'pizza',
      'american (traditional)',
      'american (new)',
      'delis',
      'burgers',
      'seafood',
      'diners',
      'italian',
      'hot dogs'
    ]
    @categories = Category.all(:conditions => {:name => categories})
    @categories.each {|c| @restaurants << c.restaurants }
    @restaurants = @restaurants.flatten.uniq
  end

  def show
    id = params[:id]
    @restaurant = Restaurant.find(id)
    @comments = MenuComment.where(:restaurant_id => id)
    @coordinates = [@restaurant[:x], @restaurant[:y]]
  end
end
