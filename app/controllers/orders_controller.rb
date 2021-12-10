class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :buyer_only, only: %i[create my_order checkout my_order order_succeed]
  before_action :admin_only, only: %i[index confirm_order deliver_order]
  before_action :set_order, only: %i[summary confirm_order deliver_order order_succeed invoice]
  before_action :owner_only, only: %i[invoice]

  def index
    @orders = Order.order(status: :asc, updated_at: :desc)
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
    @orders = Order.get_my_order(current_user).order(status: :asc, updated_at: :desc)
  end

  def confirm_order
    if @order.confirm_order
      flash[:notice] = "Order confirmation successful"
      flash[:color] = "success"
    else
      flash[:notice] = "Order confirmation failed"
      flash[:color] = "success"
    end
    redirect_to orders_path
  end

  def deliver_order
    if @order.ship
      flash[:notice] = "Order deliver successful"
      flash[:color] = "success"
    else
      flash[:notice] = "Order deliver failed"
      flash[:color] = "success"
    end

    redirect_to orders_path
  end

  def order_succeed
    if @order.succeed
      flash[:notice] = "Order confirmation successful"
      flash[:color] = "success"
    else
      flash[:notice] = "Order confirmation failed"
      flash[:color] = "success"
    end

    redirect_to my_order_orders_path
  end

  def invoice
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "Invoice",
               page_size: "A4",
               template: "orders/invoice.pdf.erb"
      end
    end
  end

  private

  def order_params
    params.require(:order)
      .permit(:user_id, :status, :order_details_attributes => [:product_id, :quantity])
  end

  def create_order_params
    params.require(:order)
      .permit(:user_id, :status, :total_price, :order_details_attributes => [:product_id, :quantity])
  end

  def buyer_only
    if current_user.level != "buyer"
      flash[:notice] = "Access Denied"
      flash[:color] = "danger"

      redirect_back(fallback_location: root_path)
    end
  end

  def admin_only
    if current_user.level != "admin"
      flash[:notice] = "Access Denied"
      flash[:color] = "danger"

      redirect_back(fallback_location: root_path)
    end
  end

  def set_order
    @order = Order.find(params[:id])
  end

  def owner_only
    if @order.user != current_user
      render "errors/not_found"
    end
  end
end
