require 'rails_helper'

RSpec.describe Book, type: :model do
  let (:book) { FactoryGirl.create :book }

  context 'is invalid when' do
    it 'without title' do
      expect(FactoryGirl.build :book, title: nil).not_to be_valid
    end
    it 'without description' do
      expect(FactoryGirl.build :book, description: nil).not_to be_valid
    end

    it 'price lower than 0.01' do      
      expect(FactoryGirl.build :book, price: 0.0).not_to be_valid
    end

    it ' title not unique' do
      expect(FactoryGirl.build :book, title: book.title).not_to be_valid
    end

    context 'associations' do
      it 'has many reviews' do
        expect(book).to respond_to(:reviews)
      end
    end
  
  end 
end
