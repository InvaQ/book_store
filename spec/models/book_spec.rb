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
  end

    context 'associations' do
      it { should have_many(:pictures)   }  
      it { should have_many(:reviews) }
      it { should have_many(:categories).through(:categorizations) }
      it { should have_many(:categorizations) }
      it { should have_many(:line_items) }
    end

    it ' should get books dimentsions' do
      expect( book.get_book_dimensions).to eq("H:#{book.height}\" x W: #{book.width}\" x D: #{book.depth}\"")
    end

    it 'should show authors names' do
      expect(FactoryGirl.create(:book_with_authors).get_author_names)
        .to eq("author_first1 author_second1, author_first2 author_second2")
    end
end
