class OrderMailer < ApplicationMailer
  def new_order
    @order = params[:order]

    mail(to: params[:receiver], subject: "You got a new order!")
  end

  def order_confirmed
    @order = params[:order]

    mail(to: params[:receiver], subject: "Your Order Confirmed")
  end

  def deliver_order
    @order = params[:order]

    mail(to: params[:receiver], subject: "Your Order On Delivery")
  end

  def order_successful
    @order = params[:order]

    mail(to: params[:receiver], subject: "Order Successful")
  end
end
