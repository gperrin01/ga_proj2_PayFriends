class DealsController < ApplicationController

  def index
    @deal = Deal.new 
    @user = User.new 
    @users = User.all 

#  Here iI MUST keep 'true' 'false', not true/false
    @pending = current_user.all_deals.select {|deal| deal.settled == 'false'}.sort_by(&:updated_at).reverse
    # binding.pry
    @history = current_user.all_deals.select {|deal| deal.settled == 't'}.sort_by(&:created_at).reverse

    @deals_to_pay = @pending.select {|deal| deal.receiver == current_user }.sort_by(&:amount).reverse
    @deals_to_receive = @pending.select {|deal| deal.payer == current_user }.sort_by(&:amount).reverse
  end

  def create

    if params[:payer]
      payer = User.find(params[:payer].to_i)
      receiver = User.find(params[:receiver].to_i)
      amount = params[:amount].to_i
      description = params[:description]
    elsif params[:deal]
      payer = User.find(params[:deal][:payer].to_i)
      receiver = User.find(params[:deal][:receiver].to_i)
      amount = params[:deal][:amount].to_i
      description = params[:deal][:description]
    end
        
    @deal = Deal.create amount: amount, payer: payer, receiver: receiver, description: description
    @time = @deal.time_create_readable
    @full_deal = {deal: @deal, time: @time, long_description: @deal.long_description(current_user)}

    respond_to do |format|
      format.html 
      format.json { render json: @full_deal, status: 200 }
    end  
  end

  def update

    @deal = Deal.find params[:id]
    # @deal.settle_now
    @deal.update(params.permit(:amount, :description, :settled))
    @time = @deal.time_create_readable

    @full_deal = {deal: @deal, time: @time, long_description: @deal.long_description(current_user)}

    respond_to do |format|
      format.html { redirect_to deals_path }
      # format.json { redirect_to deals_path }
      format.json { render json: @full_deal, status: 200 }
    end  
  end

  def show
    @deal = Deal.find params[:id] 
    @time = @deal.time_create_readable
    @full_deal = {deal: @deal, time: @time, long_description: @deal.long_description(current_user)}

    respond_to do |format|
      format.html 
      format.json { render json: @full_deal, status: 200 }
    end
  end


end