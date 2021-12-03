class OrderDetailsController < ApplicationController
  def summary
    @summary = OrderDetail.get_product_summary(params[:id]).first
    @photos = ProductPhoto.where(product_id: @summary[:id])
    @product_categories = ProductCategory.where(product_id: @summary[:id])
  end
end
