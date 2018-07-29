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
end
