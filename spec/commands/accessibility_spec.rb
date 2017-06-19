require 'rails_helper'

describe StepAccessibility do
  let(:order) { create :order}
  let(:order_complete) {create :order, :completed}
  let(:order_address) {create :order, :with_addresses}      
  let(:order_delivery) {create :order, :with_delivery}
  let(:order_card) {create :order, :with_credit_card}
  context 'not alllowed' do
    it 'broadcast wrong_url' do
      subject = StepAccessibility.new(:address, order_complete)
      expect(subject.call).to broadcast(:wrong_url)
    end
    it 'broadcast empty_cart' do
      subject = StepAccessibility.new(:address, order)
      allow_any_instance_of(StepAccessibility).to receive(:pointless_request?).and_return(false)
      expect(subject.call).to broadcast(:empty_cart)
    end
  end
  context 'when step = ' do
    before do
      allow_any_instance_of(StepAccessibility).to receive(:order_empty?).and_return(false) 
    end
    it 'address and broadcast ok' do
      subject = StepAccessibility.new(:address, order)
      expect(subject.call).to broadcast(:ok)
    end
    it 'delivery and broadcast ok' do
      subject = StepAccessibility.new(:delivery, order_address)
      expect(subject.call).to broadcast(:ok)
    end
    it 'payment and broadcast ok'  do
      subject = StepAccessibility.new(:payment, order_delivery)
      expect(subject.call).to broadcast(:ok)
    end
    it 'confirm and broadcast ok'  do
      subject = StepAccessibility.new(:confirm, order_card)
      expect(subject.call).to broadcast(:ok)
    end
    it 'complete and broadcast ok'  do
      subject = StepAccessibility.new(:complete, order_complete)
      expect(subject.call).to broadcast(:ok)
    end
    it 'delivery and broadcast not allowed' do
      subject = StepAccessibility.new(:delivery, order)
      expect(subject.call).to broadcast(:not_allowed)
    end
    it 'payment and broadcast not allowed' do
      subject = StepAccessibility.new(:payment, order)
      expect(subject.call).to broadcast(:not_allowed)
    end
    it 'confirm and broadcast not allowed' do
      subject = StepAccessibility.new(:confirm, order)
      expect(subject.call).to broadcast(:not_allowed)
    end
    it 'complete and broadcast not allowed' do
      subject = StepAccessibility.new(:complete, order)
      expect(subject.call).to broadcast(:not_allowed)
    end
  end
end
