class OrdersController < ApplicationController
    def index
      @my_string = ""
      (0...30).each {|n| @my_string += (rand(26) + 97).chr }
      @my_string += "?"
    end

    def show
      @my_other_string = "Order " + params[:id] + ": "
      (0...20).each {|n| @my_other_string += (rand(26) + 97).chr }
    end

    def new
    end

    def create
    end

    def destroy
    end
end
