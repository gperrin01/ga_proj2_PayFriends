class DealsController < ApplicationController

  def index
    @pending = @deals.unsettled_deals.sort_by(&:updated_at)


  end

end