class PagesController < ApplicationController
  def index
  	if params[:slug].nil?
  		@services = Service.where(done: false).all
  	else
  		@services = Service.includes(:category).where('categories.slug' => params[:slug], done: false).all
  	end
  	@categories = Category.all
  end
end
