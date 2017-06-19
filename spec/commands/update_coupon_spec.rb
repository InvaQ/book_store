require 'rails_helper'


RSpec.describe UpdateCoupon do
  let(:order) { create :order, :with_coupon}
  let(:new_code) { { code: "1234" } }
  let(:same_code) { { code: order.coupon.code } }
  context 'update coupon' do
    it 'when dont need update' do
      expect(UpdateCoupon.new( same_code, order).call).to eq(nil)
    end
    it ' when need update && doesnt have any coupon yet' do
      expect(UpdateCoupon.new( new_code, order).call).to eq(order.coupon)
    end
  end
end
