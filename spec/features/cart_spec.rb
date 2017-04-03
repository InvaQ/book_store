feature 'Carts page:', type: :feature do

  let(:coupon) { create :coupon }
  let(:order) { create(:order) }
  context 'when order' do

    before do
      #allow_any_instance_of(ApplicationController).to receive(:set_order).and_return(order)
      visit cart_path(id: order.id) 
    end

    it 'is empty' do
      expect(page).to have_content 'Cart is empty, You can add book here'
    end
  end
end
