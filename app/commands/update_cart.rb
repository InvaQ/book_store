class UpdateCart < Rectify::Command


  def initialize(params, cart)

    @params = params
    @cart = cart
  end

  def call
    return broadcast(:invalid, coupon_form) if coupon_form.invalid?
    action = params[:to_checkout] ? :to_checkout : :update_cart
    broadcast(action) if update_cart
  end

private
  attr_reader :cart, :coupon_form, :params
  
  def update_cart
    cart.coupon = @coupon if @coupon.present?
    cart.update_attributes(cart_params)

  end


  def coupon
    return unless params[:cart][:coupon]
    @coupon ||= Coupon.find(code: params[:cart][:coupon][:code])
  end

  def coupon_form
    @coupon_form ||= CouponForm.from_params(params)
  end

  def cart_params
    params.require(:cart).permit(line_items_attributes: [:id, :quantity])
  end
end