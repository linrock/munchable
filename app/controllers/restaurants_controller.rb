class RestaurantsController < ApplicationController

  def index
    # @restaurants = Restaurant.find(:all, :limit => 50)
    # @categories = Category.all

    @restaurants = []
    categories = ['chinese', 'mexican', 'sandwiches', 'delis', 'burgers', 'seafood', 'vegetarian', 'pizza', 'diners', 'buffets']
    @categories = Category.all(:conditions => {:name => categories})
    for category in @categories
      @restaurants << category.restaurants
    end
    @restaurants.flatten!
  end

  def show
    id = params[:id]
    @restaurant = Restaurant.find(id)
    @comments = MenuComment.where(:restaurant_id => id)
    @coordinates = [@restaurant[:x], @restaurant[:y]]
  end
end
