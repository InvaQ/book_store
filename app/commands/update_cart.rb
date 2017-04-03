class UpdateCart < Rectify::Command


  def initialize(params, object)
    @params = params
    @order = object
  end

  def call
    unless coupon_blank?
      get_coupon_form
      return broadcast(:invalid, form) if form.invalid?
    end
    action = params[:to_checkout] ? :to_checkout : :update_cart
    order.checkout if action == :to_checkout
    broadcast(action) if update_cart
  end

private
  attr_reader :order,:form, :params
  
  def update_cart
    order.coupon = @coupon if order.coupon.blank? && @coupon
    order.total_price = order.total_cart_price
    order.update_attributes(cart_params)
  end


  def get_coupon_form     
      @form = CouponForm.from_params(coupon_params)
      @coupon = Coupon.find_by_code(coupon_params[:code])   
  end

  def coupon_params
    params.require(:order).require(:coupon).permit(:code)    
  end

  def coupon_blank?
    coupon_params[:code].blank?
  end

  def cart_params
    params.require(:order).permit(line_items_attributes: [:id, :quantity])
  end

  
end