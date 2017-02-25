class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_category
  include CurrentCart
  before_action :set_cart



  private

  def set_category
    @category = Category.get_first_listed
  end

  def set_cart
    @cart = Cart.find(session[:cart_id])
  end
  
end
