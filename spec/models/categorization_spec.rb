require 'rails_helper'

RSpec.describe Categorization, type: :model do
   context 'associations' do
      it { should belong_to(:book)   }  
      it { should belong_to(:category)   }
    end
end
