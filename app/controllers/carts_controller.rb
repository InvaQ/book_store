class CartsController < ApplicationController
  include Rectify::ControllerHelpers

  before_action :set_cart, only: [:show, :edit, :update, :destroy]
  def index
    @carts = Cart.all
  end

  def new
    @cart = Cart.new
  end
  
  def create
    @cart = Cart.new
    if @cart.save
      redirect_to @cart
    else
      render action: 'new'
    end
  end

  def show
    @coupon_form = CouponForm.from_model(@cart.coupon)
    
  end

  def edit

  end

  def update
    UpdateCart.call(params.permit!, @cart) do
      on(:update_cart) { redirect_to @cart }
      on(:to_checkout) {create_order}
    end
    
  end

  def destroy    
    @cart.destroy if @cart.id == session[:cart_id]
    session[:cart_id] = nil
    redirect_to root_path
  end

  def create_order
    binding.pry
    @order = Order.new(user_id: 1)
    @order.add_line_items_from_cart(@cart)
    if @order.save
      Cart.destroy(session[:cart_id])
      session[:cart_id] = nil
      redirect_to checkout_path(:address)
    end
  end



private

  def success_update(path, *params)
    redirect_to send("#{path}_path", params)#,
                #notice: t('flash.success.cart_update')
  end

  def set_cart
    @cart = Cart.find(params[:id])
  end

end
