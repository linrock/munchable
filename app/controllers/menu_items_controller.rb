class MenuItemsController < ApplicationController

  def index
    @menu_items = MenuItem.search(:name_contains => params[:q].capitalize).all
  end
end
