class HomeController < ApplicationController
  def index
    @q = Product.search(params[:q])
    @products = Product.active_products
  end
end
