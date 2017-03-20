require 'rails_helper'

RSpec.describe Order, type: :model do

  describe 'Associations' do
    it { should belong_to(:user) }
    it { should belong_to(:delivery) }

    it { should have_one(:credit_card).dependent(:destroy) }
    it { should have_one(:coupon).dependent(:nullify) }
    it { should have_many(:line_items).dependent(:destroy) }
  end
  describe 'Order' do 
    subject { create :order }

    it 'generate_number' do
      expect(subject.generate_number).to eq("#R00#{subject.id.to_s}")
    end

  end
end
