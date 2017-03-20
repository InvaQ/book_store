require 'rails_helper'

RSpec.describe Book, type: :model do
  let (:book) { FactoryGirl.create :book }
  context ' Validation' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    context 'is invalid when' do     

      it 'price lower than 0.01' do      
        expect(FactoryGirl.build :book, price: 0.0).not_to be_valid
      end

      it ' title not unique' do
        expect(FactoryGirl.build :book, title: book.title).not_to be_valid
      end
  end

    context 'associations' do
      it { should have_many(:pictures)   }  
      it { should have_many(:reviews) }
      it { should have_many(:categories).through(:categorizations) }
      it { should have_many(:categorizations) }
      it { should have_many(:line_items) }
    end
  end
end
