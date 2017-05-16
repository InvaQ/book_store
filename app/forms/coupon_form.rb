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
    return errors.add(:code, "does not exist!") unless current_coupon
  end

  def activated_coupon?
    return unless errors.blank?
    errors.add(:code, "is out of date") if current_coupon.already_activated?
  end
end