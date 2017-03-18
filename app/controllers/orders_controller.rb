class OrdersController < ApplicationController
  load_and_authorize_resource only: :show

  def index
   # @orders = Order.all
  end

  def new  
    @order = Order.new
  end

  def show

  end

end
