class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart, only: %i[destroy]
  before_action :buyer_only

  def index
    @carts = Cart.get_my_cart(current_user)
    @order = Order.new
  end

  def create
    @cart = Cart.insert_cart(cart_params)
    if @cart
      flash[:notice] = "Keranjang telah ditambah"
      flash[:color] = "success"
    else
      flash[:notice] = "Keranjang gagal ditambah"
      flash[:color] = "danger"
    end

    redirect_back(fallback_location: root_path)
  end

  def destroy
    @cart.destroy
    redirect_to carts_path
  end

  private

  def cart_params
    params.require(:cart).permit(:user_id, :product_id, :quantity)
  end

  def set_cart
    @cart = Cart.find(params[:id])
  end

  def buyer_only
    if !user_signed_in? && current_user.level != "buyer"
      notice[:flash] = "Access Denied"
      notice[:color] = "danger"

      redirect_back(fallback_location: root_path)
    end
  end
end
