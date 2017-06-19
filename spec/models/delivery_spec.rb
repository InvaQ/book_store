require 'rails_helper'

RSpec.describe Delivery, type: :model do
  it { should have_many(:orders) }
  it { should belong_to(:country) }

  describe 'Validation' do
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:min_days) }
    it { should validate_presence_of(:max_days) }
    it 'min days less_than_or_equal_to max_days' do
      subject = create(:delivery)
      subject.min_days = 3
      subject.max_days = 1
      expect(subject.valid?).to eq false
    end
  end
  it 'should show info aboute transfer' do
    expect(FactoryGirl.build(:delivery).transfer).to eq("from 3 to 9 days")
  end
end
