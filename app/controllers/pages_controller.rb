class PagesController < ApplicationController
  def index
  	if params[:slug].nil?
  		@services = Service.where(statut: false).all
  	else
  		@services = Service.includes(:category).where('categories.slug' => params[:slug]).all
  	end
  	@categories = Category.all
  end
end
