require 'rails_helper'

RSpec.describe LineItemsController, type: :controller do
 
    subject { FactoryGirl.create(:line_item)}


  it 'should create line item' do 
    expect { post :create, line_item: subject.attributes }.to change(LineItem, :count).by(1)
  end
  it 'should show line item'
  it 'should update line item'
  it 'should destroy line item'

end
