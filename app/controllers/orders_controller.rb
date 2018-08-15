class OrdersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @orders = current_user.orders.includes(:product).all
  end

  def show
    @order = current_user.orders.find_by(id: params[:id])
  end

  def new
  end

  def create
    @order = Order.new( order_params )

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { redirect_to orders_path, notice: 'Order was not created.' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if current_user.admin
      @order = Order.find_by(id: params[:id])
      respond_to do |format|
        if( @order && @order.destroy )
          format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
          format.json { head :no_content }
        else
          format.html { redirect_to orders_url, alert: 'Order was not destroyed.' }
          format.json { head :no_content }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to orders_url, alert: 'You are not authorized to do this.' }
        format.json { head :no_content }
      end
    end

  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:user_id, :product_id, :total_in_cents)
    end
end
