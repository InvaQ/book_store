require 'rails_helper'


RSpec.describe StepAddress do
  let(:order) { create :order}
  let(:order_address) {create :order, :with_addresses}
  let(:country) {create :country }
  let(:params) { { billing: {first_name: "bob", last_name: "bob",
                             address: "bob", city: "bob", zip: "345",
                              country_id: country.id, phone: "+12345456"}}}
  let(:form) do
    AddressesForm.from_params(params[:billing])
  end
  before do
      allow_any_instance_of(StepAddress).to receive(:use_billing?).and_return(true)
      allow_any_instance_of(StepAddress).to receive(:check_shipping_params).and_return(nil)
      allow_any_instance_of(StepAddress).to receive(:address_params).and_return(params)
      allow_any_instance_of(StepAddress).to receive(:forms_invalid?).and_return(false)
    end
  context 'valid' do
    before do
      allow_any_instance_of(StepAddress).to receive(:forms_invalid?).and_return(false)
    end
    it 'create addresses' do
      command = StepAddress.new(params, order)
      expect { command.call }.to change { ShippingAddress.count }.by(1)
    end
    it 'update addresses' do
      command = StepAddress.new(params, order_address)
      expect { command.call }.not_to change { ShippingAddress.count }
    end
    it 'broadcast :ok' do
      command = StepAddress.new(params, order)
      expect { command.call }.to broadcast(:ok)
    end
  end      
  before do
    allow_any_instance_of(StepAddress).to receive(:forms_invalid?).and_return(true)
  end
  it 'broadcast invalid' do
    command = StepAddress.new(params, order)
    expect { command.call }.to broadcast(:invalid)
  end
end
