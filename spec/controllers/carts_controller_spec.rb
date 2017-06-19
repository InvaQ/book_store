require 'rails_helper'

RSpec.describe CartsController, type: :controller do
  let(:order) { create :order, :with_items}
  
  it '#show cart' do     
    get :show, id: order.id
    assert_response 200
  end

  context 'when update cart is' do
    it 'invalid' do
      params = {"id"=>"3", "controller"=>"carts", "action"=>"update"}
      allow(UpdateCart).to receive(:call).with(params, order)
      allow(UpdateCart).to receive(:new).and_return(true)
      allow_any_instance_of(UpdateCart).to receive(:coupon_blank?).and_return(false)
      allow_any_instance_of(UpdateCart).to receive(:define_action).and_return(true)
      allow_any_instance_of(UpdateCart).to receive(:update_cart).and_return(true)
      allow_any_instance_of(UpdateCart).to receive(:broadcast).and_return(:invalid)
      
      patch :update,  id: order.id
      expect(response).to redirect_to cart_path(id: order.id)
    end

    it 'valid' do
      allow(UpdateCart).to receive(:call).and_return(:update_cart)
      patch :update,  id: order.id
      expect(response).to redirect_to cart_path(id: order.id)
    end
  end
  


end