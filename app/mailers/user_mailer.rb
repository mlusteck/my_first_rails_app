class UserMailer < ApplicationMailer
  def contact_form(name, email, message)
    @message = message
    mail(
      from: email,
      to: 'mail@mischa-lusteck.de',
      subject: "A new contact form message from #{name}"
    )
  end

  def welcome(user)
    @appname = "Beasts of Berlin"
    mail(to: user.email, subject: "Welcome to #{@appname}!")
  end

  def order_notification(user,order)
    @appname = "Beasts of Berlin"
    @user_name = (user.first_name || "") + " " + (user.last_name || "")
    if @user_name == " "
      @user_name = user.email
    end
    @product_name = order.product.name
    mail(to: user.email, subject: "Your order at #{@appname}")
  end
end
