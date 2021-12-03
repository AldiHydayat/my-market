class HomeController < ApplicationController
  def index
    @products = Product.active_products
  end
end
