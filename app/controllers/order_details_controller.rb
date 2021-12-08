class OrderDetailsController < ApplicationController
  before_action :authenticate_user!

  def summary
    @summary = OrderDetail.get_product_summary(params[:id])
  end
end
