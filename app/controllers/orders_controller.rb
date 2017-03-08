class OrdersController < ApplicationController


  def index
   # @orders = Order.all
  end

  def new
    if @cart.line_items.empty?
      redirect_to root_path, notice "Your cart is empty"
      return
    end
  @order = Order.new
end

  def show
    @order = Order.find(params[:id])
  end

  def create
    @order = Order.new(params)
    @order.add_line_items_from_cart(@cart)
    if @order.save
      Cart.destroy(session[:cart_id])
      session[:cart_id] = nil
      
    end
  end

  private

end
