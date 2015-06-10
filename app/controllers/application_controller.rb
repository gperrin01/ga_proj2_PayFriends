class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  before_filter :do_common_stuff
  
  def do_common_stuff
    # @current_user
    @deals = Deal.all
    @users = User.all
    @deal_new = Deal.new
    @user_new = User.new
  end

  helper_method :current_user
  # helper method means we can use it in the view !
  private
  def current_user
    begin
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue ActiveRecord::RecordNotFound
      session[:user_id] = nil
    end
  end
  
 

end
