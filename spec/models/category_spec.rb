require 'rails_helper'

RSpec.describe Category, type: :model do
  context 'associations' do
      it { should have_many(:categorizations)   }  
      it { should have_many(:books).through(:categorizations)   }
    end

 
end
