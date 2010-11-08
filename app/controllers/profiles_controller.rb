class ProfilesController < ApplicationController

  def show
    @user = User.find(params[:user_id])
    authorize! :manage, @user.profile
  end

  def edit
  end
end
