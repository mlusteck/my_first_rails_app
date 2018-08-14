class PaymentsController < ApplicationController
  before_action :authenticate_user!
  def create
    # Token is created using Checkout or Elements!
    # Get the payment token ID submitted by the form:
    @product = Product.find(params[:product_id])    
    @user = current_user
    token = params[:stripeToken]
    @order = Order.create(user: @user, product: @product, total_in_cents: @product.price_in_cents )

    begin
      charge = Stripe::Charge.create({
          amount: @product.price_in_cents,
          currency: 'eur',
          description: params[:stripeEmail],
          source: token,
          metadata: {'order_id' => @order.id }
      })
      if !(@charge_paid = charge.paid)
        flash[:alert] = "Unfortunately, there was an error processing your payment."
      end
    rescue Stripe::CardError => e
      # The card has been declined
      body = e.json_body
      err = body[:error]
      flash[:alert] = "Unfortunately, there was an error processing your payment: #{err[:message]}"
    end
    if !@charge_paid
      @order.destroy
      redirect_to product_path(@product)
    end
  end
end
