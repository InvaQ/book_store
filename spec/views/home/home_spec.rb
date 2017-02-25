require 'rails_helper'

RSpec.describe "home/index.html.haml", type: :view do
  
  scenario 'should trasfer to log in page' do
    visit root_path
    click_link('Login')
    expect(page).to have_content('Log In')

  end
  context ' when loged in' do   
    let (:user) { FactoryGirl.create :user }

    scenario ' should not contein login button' do
      visit new_user_session_path
      within '.general-form' do
        fill_in 'Enter Email', with: user.email
        fill_in 'Password', with: user.password
        click_button('Log in')
        
      end
      expect(page).to have_content('My account')
    end
  end

  scenario 'should contein bestsellers'
  
  scenario 'should not display link to cart'
  context 'when @cart was created' do
    scenario 'should display number of line items'
    scenario 'should display link to cart'
  end

end
