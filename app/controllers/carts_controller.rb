class CartsController < ApplicationController
  include Rectify::ControllerHelpers
  include CurrentOrder

  before_action :set_order, only: [:show, :edit, :update, :destroy]
  

  def show
   
  end

  def edit

  end

  def update
    UpdateCart.call(params, @order) do
      on(:update_cart) { redirect_to cart_path(id: session[:cart_id]) }
      on(:to_checkout) {redirect_to checkout_path(:address)}
      on(:invalid) {redirect_to cart_path(id: session[:cart_id]) }
    end    
  end

  def destroy    
    @cart.destroy if @cart.id == session[:cart_id]
    session[:cart_id] = nil
    redirect_to root_path
  end



private

  def success_update(path, *params)
    redirect_to send("#{path}_path", params)#,
                #notice: t('flash.success.cart_update')
  end

end
