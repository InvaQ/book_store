class CartsController < ApplicationController
  before_action :set_cart, only: [:update, :destroy]
  def index
    @carts = Cart.all
  end

  def new
    @cart = Cart.new
  end
  
  def create
    @cart = Cart.new(cart_params)
    if @cart.save
      redirect_to @cart
    else
      render action: 'new'
    end
  end

  def destroy    
    @cart.destroy if @cart.id == session[:cart_id]
    session[:cart_id] = nil
    redirect_to root_path
  end



private
  def cart_params
    params.require(:cart)
  end

  def set_cart
    @cart = Cart.find(params[:id])
  end

end
