class ReviewsController < ApplicationController
  before_action :set_product
  before_action :set_order_detail, only: %i[new create]
  before_action :check_order_detail, only: %i[new create]

  def index
  end

  def new
  end

  def create
    @review = Review.new(review_params)
    if @review.review_product(@product, current_user, @order_detail.id)
      flash[:notice] = "Review Product Success"
      flash[:color] = "success"
      redirect_to my_order_orders_path
    else
      flash[:notice] = @review.errors.full_messages.first
      flash[:color] = "danger"
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :comment)
  end

  def set_product
    @product = Product.friendly.find(params[:product_id])
  end

  def set_order_detail
    @order_detail = OrderDetail.find(params[:od])
  end

  def check_order_detail
    if @order_detail.blank? || @order_detail.is_reviewed == true
      render "errors/not_found"
    end
  end
end
