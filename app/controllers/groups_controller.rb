class GroupsController < ApplicationController

  def new
    @group = Group.new
  end

  def create
    status = current_user.create_group(params[:group][:name])
    if status
      flash[:notice] = 'Group created!'
      redirect_to user_profile_url(:id => current_user.id)
    else
      flash[:notice] = 'Group creation failed!'
      render :action => :new
    end
  end

  def show
    @group = Group.find(params[:id])
  end
end
