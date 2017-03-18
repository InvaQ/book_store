class CartsController < ApplicationController
  include Rectify::ControllerHelpers  

  def show
   
  end

  def edit

  end

  def update
    binding.pry
    UpdateCart.call(params, @order) do
      on(:update_cart) { redirect_to cart_path(id: session[:order_id]) }
      on(:to_checkout) {redirect_to checkout_path(:address)}
      on(:invalid) {redirect_to cart_path(id: session[:order_id]) }
    end    
  end


private

  def success_update(path, *params)
    redirect_to send("#{path}_path", params)#,
                #notice: t('flash.success.cart_update')
  end

end
