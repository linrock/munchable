class ListingsController < ApplicationController

  def create
    @user = User.find(params[:user_id])
    @group = Group.find(params[:group_id])
    @restaurant = Restaurant.find(params[:rid])

    @listing = Listing.create({
      :list_id => @group.list.id,
      :restaurant_id => @restaurant.id
    })
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @listing = Listing.find(params[:id])
    @listing.destroy
    respond_to do |format|
      format.js
    end
  end
end
