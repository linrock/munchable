class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to root_url
  end

  def index
    @location = Location.find(1)
    @categories = Category.all.collect {|c| c.name }
  end
end
