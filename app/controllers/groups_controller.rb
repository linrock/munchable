class GroupsController < ApplicationController

  def new
    @group = Group.new
  end

  def create
    @user = User.find(params[:user_id])
    status = @user.create_group(params[:group][:name])
    if status
      flash[:notice] = 'Group created!'
      redirect_to user_profile_url(:id => @user.id)
    else
      flash[:notice] = 'Group creation failed!'
      render :action => :new
    end
  end

  def show
    @user = User.find(params[:user_id])
    @group = Group.find(params[:id])
    @list = @group.list
  end
end
