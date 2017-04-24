require 'rails_helper'


describe StepPayment do
  let(:order) { create :order}
  let(:credit_card) { create :credit_card }
  let (:invalid_params) {   { credit_card: {number: "12345", 
    name: "f", expiry_month: "17", expiry_year: "1990",
     cvv: "12300"}}}
  it 'broadcast invalid form' do
    allow_any_instance_of(StepPayment).to receive(:card_params)
    .and_return(invalid_params)          
    subject = StepPayment.new(invalid_params, order)
    expect(subject.call).to broadcast(:invalid)
  end
  context 'when form valid' do
    before do
      allow_any_instance_of(StepPayment).to receive(:card_params)
      .and_return(attributes_for(:credit_card))
      order.checkout
    end
    let(:subject) { StepPayment.new(attributes_for(:credit_card), order) }
    it 'create credit card' do
      expect { subject.call }.to change { CreditCard.count }.by(1)
      expect(order.credit_card.id).not_to eq(nil)
    end
    it 'update credit card data' do
      subject.call
      expect { subject.call }.not_to change { CreditCard.count }
    end
    it '#change_order_state' do
      expect { subject.call }.to change { order.state }
    end
  end
end
