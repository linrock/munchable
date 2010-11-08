class ListingsController < ApplicationController

  def create
    @user = User.find(params[:user_id])
    @group = Group.find(params[:group_id])
    @restaurant = Restaurant.find(params[:rid])

    if Listing.where(:list_id => @group.list.id, :restaurant_id => @restaurant.id).empty?
      @listing = Listing.create({
        :list_id => @group.list.id,
        :restaurant_id => @restaurant.id
      })
    else
      flash[:notice] = 'Restaurant already exists!'
    end
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
