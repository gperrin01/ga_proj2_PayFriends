class DealsController < ApplicationController

  def index
    session[:logged_in] = User.find(params[:logged_id])
    @pending = @deals.unsettled_deals.sort_by(&:updated_at)
    @history = @deals.settled_deals.sort_by(&:created_at)
  end

end