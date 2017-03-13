class CouponForm < Rectify::Form
  attribute :code, String

  validates :code, presence: true
  validate :exist_coupon?
  validate :activated_coupon?

  private

  def current_coupon
    Coupon.find_by_code(code)
  end

  def exist_coupon?
    current_coupon
  end

  def activated_coupon?
    binding.pry
    current_coupon.activated? if current_coupon
  end
end