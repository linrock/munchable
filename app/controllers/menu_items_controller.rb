class MenuItemsController < ApplicationController

  def index
    @menu_items = MenuItem.search(:name_contains => params[:q]).all
  end
end
