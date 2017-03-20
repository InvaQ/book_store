require 'rails_helper'

RSpec.describe CreditCard, type: :model do
  context 'association' do
    it { should belong_to :user }
    it { should belong_to(:order) }
  end
end
