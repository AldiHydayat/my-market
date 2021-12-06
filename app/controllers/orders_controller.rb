class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :buyer_only, only: %i[create my_order checkout my_order]
  before_action :set_order, only: %i[summary confirm_order deliver_order order_succeed]

  def index
    @orders = Order.order(status: :asc)
  end

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
    @order = Order.new(create_order_params)

    if @order.create_order
      flash[:notice] = "Order Berhasil"
      flash[:color] = "success"
      redirect_to root_path
    else
      flash[:notice] = "Order Gagal"
      flash[:color] = "danger"
      redirect_to carts_path
    end
  end

  def my_order
    @orders = Order.get_my_order(current_user).order(status: :asc)
  end

  def confirm_order
    @order.confirm_order

    OrderMailer.with(order: @order, receiver: @order.user.email).order_confirmed.deliver_later

    redirect_to orders_path
  end

  def deliver_order
    @order.ship
    @order.save

    OrderMailer.with(order: @order, receiver: @order.user.email).deliver_order.deliver_later

    redirect_to orders_path
  end

  def order_succeed
    @order.succeed
    @order.save

    admin = User.find_by(level: "admin").slice(:email)

    OrderMailer.with(order: @order, receiver: admin).deliver_order.deliver_later

    redirect_to my_order_orders_path
  end

  private

  def order_params
    params.require(:order).permit(:user_id, :status, :order_details_attributes => [:product_id, :quantity])
  end

  def create_order_params
    params.require(:order).permit(:user_id, :status, :total_price, :order_details_attributes => [:product_id, :quantity])
  end

  def buyer_only
    if !user_signed_in? && current_user.level != "buyer"
      notice[:flash] = "Access Denied"
      notice[:color] = "danger"

      redirect_back(fallback_location: root_path)
    end
  end

  def set_order
    @order = Order.find(params[:id])
  end
end
