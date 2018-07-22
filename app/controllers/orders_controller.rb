class OrdersController < ApplicationController
  def index
    @my_string = ""
    (0...30).each {|n| @my_string += (rand(26) + 97).chr }
    @my_string += "?"
    @orders = Order.all
  end

  def show
    @my_other_string = "Order " + params[:id] + ": "
    (0...20).each {|n| @my_other_string += (rand(26) + 97).chr }
  end

  def new
  end

  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @order = Order.find(params[:id]) #!!! this should not be necessary
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
