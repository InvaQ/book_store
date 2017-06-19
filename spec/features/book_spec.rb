feature 'Book page:' do
  let(:order) { create :order, :with_items }
  subject { create :book }
  background do
    visit book_path(id: subject.id)
  end

  scenario 'can add to cart' do
    expect(page).to have_current_path book_path(id: subject.id)
    click_button 'Add to Cart'
    within('.shop-quantity') do
      expect(page).to have_content('1')
    end
    expect(page).to have_current_path book_path(id: subject.id)
  end  
end

feature 'post Review' do
  let(:order) { create :order, :with_items }
  let(:user) { create :user }
  let(:book) { create :book }

  background do
    login_as(user)
    visit book_path(id: book.id)
  end

  scenario 'user not auth' do
    logout(:user)
    visit book_path(id: book.id)
    expect(page).to have_no_css('#review_form')
    expect(page).to have_link 'Sign in'
  end      
  scenario 'user auth' do
    expect(page).to have_current_path book_path(id: book.id)
      within(".mb-80") do
      fill_in 'Title', with: attributes_for(:review)[:title]
      fill_in 'Review', with: attributes_for(:review)[:description]
      choose("rate_3", visible: false)
      click_button 'Save'
      end
      expect(page).to have_content 'Thanks for Review.
        It will be published as soon as Admin will approve it.'
  end
end