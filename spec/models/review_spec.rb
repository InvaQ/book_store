require 'rails_helper'

RSpec.describe Review, type: :model do

  context 'validation' do 
    it { should belong_to(:user) }
    it { should belong_to(:book) }
  end

  subject { build :review }

  context 'aasm state' do
    it 'unchecked able to approved' do
      expect(subject).to transition_from(:unchecked).to(:approved)
        .on_event(:approve)
    end
    it 'unchecked able to rejecte' do
      expect(subject).to transition_from(:unchecked).to(:rejected)
        .on_event(:reject)
    end
  end

  it 'should return TRUE if user already bought this book' do
    expect(FactoryGirl.create(:review, :with_verified_user).verified?).to eq(true)
  end


end
