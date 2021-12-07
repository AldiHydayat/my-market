class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_only, only: %i[index new create edit update destroy active_toggle]
  before_action :set_product, only: %i[show edit update destroy active_toggle wishlist_toggle]

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

  def show
    @cart = Cart.new
  end

  def edit
    @categories = Category.all
    @category = Category.new
  end

  def update
    if @product.update(edit_product_params)
      flash[:notice] = "Edit Product successful"
      flash[:color] = "success"
      redirect_to products_path
    else
      flash[:notice] = "Edit Product Failed"
      flash[:color] = "danger"
      redirect_to product_path(@product)
    end
  end

  def destroy
    @product.destroy

    redirect_to products_path
  end

  def active_toggle
    @product.is_active_toggle

    redirect_to products_path
  end

  def search
    redirect_to root_path if params[:keyword].blank?

    @products = Product.search_products(params[:keyword])
  end

  def wishlist_toggle
    @product.wishlist_toggle(current_user)

    redirect_back(fallback_location: root_path)
  end

  def my_wishlist
    @products = current_user.find_liked_items
    render "home/index"
  end

  private

  def product_params
    params.require(:product)
      .permit(:name, :description, :price, :stock, :is_active,
              :product_photos_attributes => [:photo],
              :product_categories_attributes => [:category_id])
  end

  def edit_product_params
    params.require(:product)
      .permit(:name, :description, :price, :stock, :is_active,
              :product_photos_attributes => [:photo],
              :product_categories_attributes => [:id, :category_id])
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
