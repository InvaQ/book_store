require 'rails_helper'

RSpec.describe Category, type: :model do
  context 'associations' do
      it { should have_many(:categorizations)   }  
      it { should have_many(:books).through(:categorizations)   }
    end

    context 'model methods' do 
      it' should count categories' do
        expect(FactoryGirl.create(:category).books_in_category).to eq(5)
      end

      it ' should get first 3 listed categories' do
        3.times do 
          FactoryGirl.create(:category)
        end
        expect(Category.get_first_listed).to eq(Category.first(3))
      end
    end

 
end
