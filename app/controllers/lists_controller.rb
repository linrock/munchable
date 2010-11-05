class ListsController < ApplicationController

  def show
  end
  
  def update
    rid = params[:rid]
    name = params[:q]

    list = List.where(:group_id => params[:group_id]).first
    list.restaurants << Restaurant.find(params[:rid])
    list.save

    render :json => ['asdf']
  end
end
