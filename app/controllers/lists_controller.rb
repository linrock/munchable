class ListsController < ApplicationController

  def show
  end
  
  def update
    rid = params[:rid]
    name = params[:q]

    restaurant = Restaurant.find(params[:rid])
    if restaurant
      list = List.where(:group_id => params[:group_id]).first
      list.restaurants << restaurant
      list.save
      render :json => {
        :name => restaurant.name,
        :address => restaurant.address,
        :hours => restaurant.hours,
        :website => restaurant.website,
        :rating => restaurant.rating,
        :review_count => restaurant.review_count,
        :take_out => restaurant.take_out,
        :delivery => restaurant.delivery,
        :x => restaurant.xy.x,
        :y => restaurant.xy.y
      }
    else
      render :json => 0
    end
  end
end
