class DealsController < ApplicationController

  def index
    @pending = Deal.all.unsettled_deals.select {|deal| deal.payer.id == current_user.id || deal.receiver.id == current_user.id }.sort_by(&:updated_at)

    # @history = @deals.settled_deals.sort_by(&:created_at)
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

#  this didnt really work and returned errors:  User(#70197021758400) expected, got String(#70196953959220) - normal because param[:payer] returned a string '40' when what I want is User.find(params[:payer]) -> question is how do I define this method using this 'transformation' of the params elements
# private
#   def deal_params
#     params.permit(:amount, :payer, :receiver, :description)
#   end

end