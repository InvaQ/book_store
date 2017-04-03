require 'rails_helper'

RSpec.describe LineItem, type: :model do

  describe 'Associations' do
    it { should belong_to(:order) }
    it { should belong_to(:book) }
  end

  it 'should calc #total price' do
    expect(FactoryGirl.create(:book_with_line_items).line_items[0].total_price).to eq(10.99)
  end
  
end
