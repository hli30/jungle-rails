class UserMailer < ApplicationMailer
  default from: "no-reply@jungle.com"

  def confirm_email(order)
    @order = order
    mail(to: @order.email,
         subject: "Jungle Order ID: #{@order.id} - Thank you for your purchase")
  end
end
