class PagesController < ApplicationController
  def index
  	@services = Service.where(statut: false).all
  	@categories = Category.all
  end
end
