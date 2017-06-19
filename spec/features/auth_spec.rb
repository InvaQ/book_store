
feature 'Authentication' do
  context 'when user exists in db' do
    subject { create :user }

    context 'when log in' do
      before { visit new_user_session_path }

      scenario 'success log in' do
        within('.general-form') do
          fill_in 'Enter Email', with: subject.email
          fill_in 'Password',    with: subject.password
        end
        click_button 'Log in'
        expect(page).to have_content I18n.t('devise.sessions.signed_in')
      end

      scenario 'wrong password' do
        within('.general-form') do
          fill_in 'Enter Email', with: subject.email
          fill_in 'Password',    with: 'wrong'
        end
        click_button 'Log in'
        expect(page).to have_content 'Invalid Email or password'
      end
    end
  end

  context 'when user doesn\'t exist in database' do
    subject { build :user }

    scenario 'sign in' do
      visit new_user_registration_path
      within('.general-form') do
        fill_in 'Enter Email',      with: subject.email
        fill_in 'Password',         with: subject.password, match: :prefer_exact
        fill_in 'Confirm Password', with: subject.password, match: :prefer_exact
        find('input[type="submit"]').click
      end
      expect(page).to have_content 'Welcome! You have signed up successfully'
    end
  end

  
end
