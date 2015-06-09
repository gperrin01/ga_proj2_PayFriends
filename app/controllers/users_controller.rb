class UsersController < ApplicationController

  def create
    @user = User.create name: params[:name]
    if request.xhr?    
      binding.pry
      @user
    else
      redirect_to '/'
    end
  end


end