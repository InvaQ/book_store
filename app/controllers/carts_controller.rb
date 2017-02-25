class CartsController < ApplicationController
  before_action :set_cart, only: [:show, :edit, :update, :destroy]
  def index
    @carts = Cart.all
  end

  def new
    @cart = Cart.new
  end
  
  def create
    #byebug
    @cart = Cart.new
    if @cart.save
      redirect_to @cart
    else
      render action: 'new'
    end
  end

  def show
    
  end

  def edit

  end

  def update
    if @cart.update(cart_params)
      redirect_to @cart
    else
      render action: 'edit'
    end

  end

  def destroy    
    @cart.destroy if @cart.id == session[:cart_id]
    session[:cart_id] = nil
    redirect_to root_path
  end



private
  
  def cart_params
      params[:cart]
    end

  def set_cart
    @cart = Cart.find(params[:id])
  end

end
