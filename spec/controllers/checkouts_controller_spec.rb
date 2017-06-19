require 'rails_helper'

RSpec.describe CheckoutsController, type: :controller do
  let(:user) { create :user }
  let(:params) { { id: :delivery, order: {} } }
  let(:order) { create :order}
  let(:confirm_stage_order) { create :order, :already_confirm}
  before do
    sign_in user
  end
  it 'redirect_to next path' do
    Support::Ok.object = order
    stub_const('StepDelivery', Support::Ok)
    patch :update, params: params
    expect(response).to redirect_to checkout_path(:payment)
  end


  it 'redirect_to confirm page' do
    Support::Ok.object = confirm_stage_order
    
    stub_const('StepDelivery', Support::Ok)
    patch :update, params: params
    expect(response).to redirect_to checkout_path(:confirm)
  end

end


module Support
    def self.const_missing(name)
      new_class = Class.new(Rectify::Command) do
        class << self
          attr_accessor :object
        end
        def initialize(*attrs)
          @order = self.class.object
        end

        def call
          broadcast(broadcast_sign, @order)
        end

        private
          def broadcast_sign
            self.class.name.split('::').last.underscore.to_sym
          end
      end

      const_set(name.to_s, new_class)
    end
end