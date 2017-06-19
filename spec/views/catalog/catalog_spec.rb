require 'rails_helper'

RSpec.describe "catalog/index.html.haml", type: :view do
  feature 'Catalog should' do
    background do
    
      #FactoryGirl.create_list :book, 10
      FactoryGirl.create :category
    end
    scenario 'contain categories', focus: true do    
      visit '/catalog'
      expect(page).to have_content("Mobile Development")
    end

    scenario 'display amount of books in categories' 
  end
  scenario 'should have button Show more'
  context 'when do sorting' do
    scenario 'should contein only sorted books'
  end





end