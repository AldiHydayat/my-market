class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :buyer_only, only: %i[create my_order]

  def checkout
    @order = Order.new(order_params)
    @order.valid?
    if @order.errors["order_details.quantity"].blank?
      @order.set_total_price
    else
      flash[:notice] = "Quantity cannot be blank"
      flash[:color] = "danger"
      redirect_to carts_path
    end
  end

  def create
    @order = Order.new(order_params)
    @order.total_price = params[:order][:total_price]

    if @order.save
      Cart.destroy_my_cart(current_user)
      flash[:notice] = "Order Berhasil"
      flash[:color] = "success"
      redirect_to root_path
    else
      flash[:notice] = "Order Gagal"
      flash[:color] = "danger"
      redirect_to carts_path
    end
  end

  private

  def order_params
    params.require(:order).permit(:user_id, :status, :order_details_attributes => [:product_id, :quantity, :product_summary])
  end

  private

  def buyer_only
    if !user_signed_in? && current_user.level != "buyer"
      notice[:flash] = "Access Denied"
      notice[:color] = "danger"

      redirect_back(fallback_location: root_path)
    end
  end
end
