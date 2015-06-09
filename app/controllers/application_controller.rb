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

  #   private
  # def current_user
  #   @_current_user ||= session[:current_user_id] &&
  #     User.find_by(id: session[:current_user_id])
  # end
  
 

end
