require 'rails_helper'


describe StepDelivery do
  let(:order) { create :order}
  let(:delivery) { create :delivery}
  let(:invalid_params) { { delivery_id: "5000" } }
  context 'valid delivery' do
      let(:valid_params) { { delivery_id: delivery.id }}
      let(:subject) { StepDelivery.new(valid_params, order) }
    before do
      allow_any_instance_of(Order).to receive(:user_id).and_return(true)
    end
    it '#add delivry' do
      subject.call
      expect(order.delivery_id).to eq(valid_params[:delivery_id].to_i)
    end
    it 'include delivery price to total price' do #delivery_p 20, order_p 0
      subject.call
      expect(order.total_price).to eq(20.00)
    end
  end
  it'broadcast invalid delivery' do
    command = StepDelivery.new(invalid_params, order)
    expect(command.call).to broadcast(:invalid)
  end
end
