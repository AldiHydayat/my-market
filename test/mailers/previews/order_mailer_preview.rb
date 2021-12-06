# Preview all emails at http://localhost:3000/rails/mailers/order_mailer
class OrderMailerPreview < ActionMailer::Preview
  def new_order
    @order = Order.first

    OrderMailer.with(order: @order, receiver: User.find_by(level: "admin").email).new_order
  end

  def order_confirmed
    @order = Order.first

    OrderMailer.with(order: @order, receiver: @order.user.email).order_confirmed
  end

  def deliver_order
    @order = Order.first

    OrderMailer.with(order: @order, receiver: @order.user.email).deliver_order
  end
end
