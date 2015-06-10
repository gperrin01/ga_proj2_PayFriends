class UsersController < ApplicationController

  def index
      @users = User.all 
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params.require(:user).permit(:name, :email, :password, :password_confirmation))
    if @user.save
      redirect_to root_path
    else
      render :new
    end
  end

  def create_friend
    @user = User.create name: params[:name]
    
    respond_to do |format|
      format.html { redirect_to deals_path }
      format.json { render json: @user, status: 200 }
    end    
  end


end