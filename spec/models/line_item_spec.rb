require 'rails_helper'

RSpec.describe LineItem, type: :model do

  describe 'Associations' do
    it { should belong_to(:order) }
    it { should belong_to(:book) }
  end
  
end
