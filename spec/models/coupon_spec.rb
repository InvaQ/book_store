require 'rails_helper'

RSpec.describe Coupon, type: :model do
  it { should belong_to(:order) }
  context 'validation' do    
    it { should validate_presence_of(:discount) }
    it { should validate_numericality_of(:discount).is_less_than_or_equal_to(99) }
    it { should validate_numericality_of(:discount).is_greater_than_or_equal_to(0) }
  end
end
