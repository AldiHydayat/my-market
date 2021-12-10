class OrderDetailsController < ApplicationController
  before_action :authenticate_user!

  def summary
    @order_detail = OrderDetail.find(params[:id])
    @summary = OrderDetail.get_product_summary(params[:id])
  end
end
