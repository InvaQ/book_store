feature 'Admin panel:' do
  context 'when user' do
    before { sign_in create(:user) }

    scenario 'cannot visit' do
      visit rails_admin_path
      expect(page).to have_content 'Access forbidden'
    end
  end

  context 'when admin' do
    before { sign_in create(:admin) }

    scenario 'can visit' do
      visit rails_admin_path
      expect(current_path).to eq rails_admin_path
    end
  end
end