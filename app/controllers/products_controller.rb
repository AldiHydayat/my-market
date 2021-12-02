class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_only
  before_action :set_product, only: %i[edit update destroy active_toggle]

  def index
    @products = Product.all
  end

  def new
    @categories = Category.all
    @product = Product.new
  end

  def create
    @categories = Category.all
    @product = Product.new(product_params)

    if @product.save
      redirect_to products_path
    else
      render "new"
    end
  end

  def edit
    @categories = Category.all
  end

  def update
  end

  def destroy
    @product.destroy

    redirect_to products_path
  end

  def active_toggle
    @product.is_active_toggle

    redirect_to products_path
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :stock, :is_active, :product_photos_attributes => [:photo], :product_categories_attributes => [:category_id])
  end

  def admin_only
    if !user_signed_in? && current_user.level != :admin
      redirect_to root_path
    end
  end

  def set_product
    @product = Product.friendly.find(params[:id])
  end
end
