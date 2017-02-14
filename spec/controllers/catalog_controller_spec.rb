require 'rails_helper'

RSpec.describe CatalogController, type: :controller do
  let(:book) { FactoryGirl.create(:book) }
  let(:category) { FactoryGirl.create(:category) }
  
 

  describe ' GET #index ' do
    before do
      allow(Book).to receive(:order).and_return book
    end

    it 'receives and order books' do
      expect(Book).to receive(:order).with('price asc').and_return book
    end
  end
end
