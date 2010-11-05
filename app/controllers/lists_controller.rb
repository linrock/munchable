class ListsController < ApplicationController

  def show
  end
  
  def update
    rid = params[:rid]
    name = params[:q]

    render :json => ['asdf']
  end
end
