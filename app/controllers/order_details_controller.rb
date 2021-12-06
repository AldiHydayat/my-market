class OrderDetailsController < ApplicationController
  def summary
    @summary = OrderDetail.get_product_summary(params[:id]).first
  end
end
