class DiscussesController < ApplicationController
  before_action :authenticate_user!, except: %i[index]
  before_action :set_product
  before_action :set_discuss, only: %i[destroy]

  def index
    @discusses = Discuss.get_discusses_product(@product.id)
    @discuss = Discuss.new
  end

  def create
    @discusses = Discuss.get_discusses_product(@product.id)
    @discuss = Discuss.new(discuss_params)
    @discuss.product = @product
    if @discuss.save
      flash[:notice] = "Menambah discuss berhasil"
      flash[:color] = "success"

      redirect_to product_discusses_path
    else
      flash[:notice] = "Menambah discuss gagal"
      flash[:color] = "danger"

      render "index"
    end
  end

  def create_reply
    @discusses = Discuss.get_discusses_product(@product.id)
    @discuss = Discuss.new(reply_discuss_params)
    @discuss.product = @product
    if @discuss.save
      flash[:notice] = "Reply discuss berhasil"
      flash[:color] = "success"

      redirect_to product_discusses_path
    else
      flash[:notice] = "Reply discuss gagal"
      flash[:color] = "danger"

      render "index"
    end
  end

  def destroy
    if @discuss.destroy
      flash[:notice] = "Hapus discuss berhasil"
      flash[:color] = "success"

      redirect_to product_discusses_path
    else
      flash[:notice] = "Hapus discuss gagal"
      flash[:color] = "danger"

      render "index"
    end
  end

  private

  def discuss_params
    params.require(:discuss).permit(:product_id, :user_id, :comment)
  end

  def reply_discuss_params
    params.require(:discuss).permit(:product_id, :user_id, :comment, :discuss_id)
  end

  def set_product
    @product = Product.friendly.find(params[:product_id])
  end

  def set_discuss
    @discuss = Discuss.find(params[:id])
  end
end
