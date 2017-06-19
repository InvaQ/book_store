require 'rails_helper'

RSpec.describe Author, type: :model do
  

  context 'Validation' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end

  context 'Association' do
    it { should have_and_belong_to_many(:books) }
  end

  context ' methods' do
    subject { create(:author, first_name: 'bob', last_name: 'bobov') }
    it 'should return #full_name' do
      expect(subject.name).to eq("#{subject.first_name} #{subject.last_name}")
    end

  end

end
