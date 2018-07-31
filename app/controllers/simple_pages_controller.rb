class SimplePagesController < ApplicationController
  def index
  end

  def landing_page
    @featured_product = Product.first
    @products = Product.limit(3)
  end

  def redirect_home
    redirect_to "/simple_pages/landing_page", notice: 'You were redirected to the landing page.'
  end

  def thank_you
    @name = params[:name]
    @email = params[:email]
    @message = params[:message]
    ActionMailer::Base.mail(
      from: @email,
      to: 'mail@mischa-lusteck.de',
      subject: "A new contact form message from #{@name}",
      body: @message
    ).deliver_now
  end
end
