require 'rails_helper'

feature 'Addresses step', type: :feature do
  let(:user) { create :user_with_addresses }
  let(:order) { FactoryGirl.create :order, :with_items, user: user }

  background do
    @order = order
    allow_any_instance_of(ApplicationController).to receive(:set_order).and_return(order)
    allow_any_instance_of(StepAccessibility).to receive(:pointless_request?).and_return(false)
    allow_any_instance_of(StepAccessibility).to receive(:order_empty?).and_return(false)
    allow_any_instance_of(CheckoutsController).to receive(:complete?).and_return(false)
    login_as(user)
  end

  # scenario 'When user not fill shipping address' do
  #   visit checkout_path(id: :address)
  #   click_button 'save_and_continue'
  #   expect(page).to have_content 'errors.messages.blank'
  # end

 

  
end