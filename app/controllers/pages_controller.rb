class PagesController < ApplicationController
  def index
  	@services = Service.where(statut: false).all
  end
end
