class CartsController < ApplicationController
  include Rectify::ControllerHelpers
 
  def show
    present OrderSummaryPresenter.new(order: @order)
  end

  def update
    UpdateCart.call(params, @order) do
      on(:update_cart) { redirect_to cart_path(id: session[:order_id]),  notice: 'Cart was successfuly updated!' }
      on(:to_checkout) {redirect_to checkout_path(:address)}
      on(:invalid) {|*attrs| redirect_to cart_path(@order),  alert: "#{@form.errors.full_messages}"
       }
    end    
  end


end
