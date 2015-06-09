class UsersController < ApplicationController

  def welcome
    @current_user = User.new
  end

  def login
    temp = User.where(name: params[:name]).first_or_create
    session[:logged_id] = temp.id
    


    # at this point current_user totally looks saved on the database (see pry), but whwn redirected to deals_path, i've lost @curruser

    redirect_to deals_path
  end

  def create
    @user = User.create name: params[:name]
    
    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { render json: @user, status: 200 }
    end    
  end


end