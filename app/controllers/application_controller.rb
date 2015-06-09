class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :do_common_stuff
  
    def do_common_stuff
      @gui = User.where(name: 'Gui').first
      @deals = Deal.all
      @users = User.all
      @deal_new = Deal.new
      @user_new = User.new
    end

end
