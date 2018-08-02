class OrdersController < ApplicationController
  skip_before_action :verify_authenticity_token # order test create!!!
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @orders = Order.includes(:product).where( user_id: current_user )
  end

  def show
    @order = Order.find_by(id: params[:id])
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
    @order = Order.find(params[:id])
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:user_id, :product_id, :total)
    end
end
