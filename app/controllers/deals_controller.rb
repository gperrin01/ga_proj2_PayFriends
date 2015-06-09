class DealsController < ApplicationController

  def index
    @current_user = session[:logged_user]
    @pending = @deals.unsettled_deals.sort_by(&:updated_at)
    @history = @deals.settled_deals.sort_by(&:created_at)
  end

end