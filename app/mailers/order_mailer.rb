class OrderMailer < ApplicationMailer
  def new_order
    @order = params[:order]

    mail(to: "f38ea720a7-903c91@inbox.mailtrap.io", subject: "You got a new order!")
  end
end
