class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  before_filter :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    if !@current_user.points
    	@current_user.points = 0
    end
  end
end