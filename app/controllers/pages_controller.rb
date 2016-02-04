class PagesController < ApplicationController
  def index
  	@services = Service.all
  end
end
