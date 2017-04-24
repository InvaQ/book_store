class UpdateCart < Rectify::Command


  def initialize(params, object)
    @params = params
    @order = object
    @update_coupon = UpdateCoupon.new(coupon_params, @order, coupon_blank?)
  end

  def call
    unless coupon_blank?
      return broadcast(:invalid, form) if form_invalid?
    end
    action = define_action
    order.checkout if action == :to_checkout
    broadcast(action) if update_cart
  end

private
  attr_reader :order, :form, :params
  
  def update_cart
    @update_coupon.call
    order.total_price = order.total_cart_price
    order.update_attributes(cart_params)
  end

  def define_action
    params[:to_checkout] ? :to_checkout : :update_cart
  end

  def form_invalid?
    @form = CouponForm.from_params(coupon_params)
    @form.invalid?        
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