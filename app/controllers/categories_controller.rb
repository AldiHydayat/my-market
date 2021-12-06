class CategoriesController < ApplicationController
  before_action :admin_only
  before_action :set_category, only: %i[edit update destroy]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path
    else
      render "new"
    end
  end

  def edit
  end

  def update
    # TIDAK ADA KONDISI GAGAL
    @category.update(category_params)

    redirect_to categories_path
  end

  def destroy
    @category.destroy

    redirect_to categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = Category.friendly.find(params[:id])
  end

  def admin_only
    if !user_signed_in? && current_user.level != :admin
      redirect_to root_path
    end
  end
end
