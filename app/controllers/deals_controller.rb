class DealsController < ApplicationController

  def index
    @deal = Deal.new 
    @user = User.new 
    @users = User.all 

    @pending = current_user.all_deals.select {|deal| deal.settled == false}.sort_by(&:updated_at)

    @history = current_user.all_deals.select {|deal| deal.settled == true}.sort_by(&:created_at)
  end

  def create
    payer = User.find(params[:payer].to_i)
    receiver = User.find(params[:receiver].to_i)
    amount = params[:amount].to_i

    @deal = Deal.create amount: amount, payer: payer, receiver: receiver, description: params[:description]

    @full_deal = {deal: @deal, long_description: @deal.long_description(current_user)}

    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { render json: @full_deal, status: 200 }
    end  
  end


end