class ListingsController < ApplicationController

  def destroy
    list = Group.find(params[:group_id]).list
    listing = list.listings.where(:restaurant_id => params[:rid]).first
    if listing.destroy
      render :json => 1
    else
      render :json => 0
    end
  end
end
