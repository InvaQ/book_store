class CouponForm < Rectify::Form
  attribute :code, String

  #validates :exist_coupon?
  #validates :activated_coupon?

  private

  def current_coupon
    @current_coupon ||= Coupon.find(code: code)
  end

  def exist_coupon?
    return if code.blank? || !current_coupon.blank?
  end

  def activated_coupon?
    return if current_coupon.activated?
  end
end