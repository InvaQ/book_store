require 'rails_helper'

RSpec.describe StepConfirm do
   let(:order) { create :order}
   let(:invalid_params) {  { place_order: "5000" }} 
   let(:valid_params) {  { place_order: "true" }} 
   let(:subject) { StepConfirm.new(invalid_params, order)}

   it 'broadcast invalid' do
    allow_any_instance_of(StepConfirm).to receive(:confirm_params)
    .and_return(invalid_params)
    expect(subject.call).to broadcast(:invalid)
   end
   
   it '#place_order' do
    allow_any_instance_of(StepConfirm).to receive(:confirm_params)
    .and_return(valid_params)
    order.checkout
    order.filling_payment
    expect { subject.call }.to change { order.state }
   end
end

