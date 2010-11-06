class ProfilesController < ApplicationController

  def show
    @user = User.find(params[:user_id])
    if not can? :manage, @user
      flash[:error] = "Hey, you're not supposed to be here!"
    end
  end

  def edit
  end
end
