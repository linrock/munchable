class GroupsController < ApplicationController

  def create
    @user = User.find(params[:user_id])
    @group = @user.create_group(params[:group_name])

    respond_to do |format|
      format.js
    end
  end

  def show
    @user = User.find(params[:user_id])
    @group = Group.find(params[:id])
    @list = @group.list

    @restaurant_listings = @list.listings.zip(@list.restaurants)
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    respond_to do |format|
      format.js
    end
  end
end
