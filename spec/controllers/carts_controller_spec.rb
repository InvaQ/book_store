require 'rails_helper'

RSpec.describe CartsController, type: :controller do
  before(:all) do
    @cart = FactoryGirl.create(:cart)
  end

  it 'get #index' do
    get :index
    assert_response :success
    expect(assigns(:carts)).not_to be(nil)
  end

  context '#create' do
    subject { post :create, params: {cart: {} } }
    it 'should #create cart' do
      expect{ subject }.to change(Cart, :count).by(1)
    end
    it 'redirect to cart' do 
      expect(subject).to redirect_to(assigns(:cart))
    end
    it "else render 'new'" do
      cart = double('cart', save: false)
      expect(Cart).to receive(:new).and_return(cart)
      expect(subject).to render_template(:new)
    end

end
  it '#show cart' do
     
    get :show, id: @cart
    assert_response 200
  end
  it '#edit cart' do
    get :edit, id: @cart
    assert_response 200
  end
  # it '#update cart', focus: true do
  #   byebug
  #   patch :update, id: @cart,  cart: @cart.attributes
  #   endassert_redirected_to cart_path(assigns(:cart))
  # end
   context '#destroy' do

    it 'only own cart' do
      expect{
        session[:cart_id] = @cart.id
        delete :destroy, id: @cart
      }.to change(Cart, :count).by(-1)
    end

  end


end
