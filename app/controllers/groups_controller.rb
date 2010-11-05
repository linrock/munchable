class GroupsController < ApplicationController

  def create
    @user = User.find(params[:user_id])
    group = @user.create_group(params[:group_name])
    if group
      flash[:notice] = 'Group created!'
      render :json => {
        :id => group.id,
        :name => group.name
      }
    else
      flash[:notice] = 'Group creation failed!'
      render :json => 0
    end
  end

  def show
    @user = User.find(params[:user_id])
    @group = Group.find(params[:id])
    @list = @group.list
  end
end
