require 'rails_helper'

describe UpdateCart do
  let(:order) { create :order}
  let(:params) {  {"line_items_attributes"=>{"0"=>{"quantity"=>"2", "id"=>"1"}}} }
  subject {UpdateCart.new(params, order)}
  before do
    allow_any_instance_of(UpdateCart).to receive(:coupon_params).and_return({code: '123'})
  end    
  context 'update cart' do
    it 'when coupons code wrong' do
      allow_any_instance_of(UpdateCart).to receive(:coupon_blank?).and_return(false)
      allow_any_instance_of(UpdateCart).to receive(:form_invalid?).and_return(true)
      expect(subject.call).to broadcast(:invalid)
    end
    context 'when action ' do
      before do
        allow_any_instance_of(UpdateCart).to receive(:coupon_blank?).and_return(true)
        allow_any_instance_of(UpdateCart).to receive(:update_cart).and_return(:true)
      end
      it 'to_checkout' do
        allow_any_instance_of(UpdateCart).to receive(:define_action).and_return(:to_checkout)
        expect(subject.call).to broadcast(:to_checkout)
      end
      it 'update_cart' do
        allow_any_instance_of(UpdateCart).to receive(:define_action).and_return(:update_cart)
        expect(subject.call).to broadcast(:update_cart)
      end
    end
    it 'successfuly' do 
      allow_any_instance_of(Order).to receive(:total_cart_price).and_return(10.00)
      allow_any_instance_of(Order).to receive(:update_attributes).and_return(true)
      allow_any_instance_of(UpdateCart).to receive(:cart_params).and_return(params)
      subject.send(:update_cart)
      expect(order.total_price).to eq(10.00)
    end
  end
end