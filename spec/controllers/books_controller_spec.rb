require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  subject { create :book }
  let(:user) { create :user }


  describe '#show' do
    context 'when book found' do
      before do
        get :show, params: { id: subject.id }
      end
      it 'assigns book' do
        expect(assigns(:book)).to eq(subject)
      end

      it 'assigns the requested book' do
        expect(assigns(:book)).to eq(subject)
      end
      it 'renders the :show template' do
        expect(response).to render_template(:show)
      end
    end
  end  

  describe '#create_line_item' do  
    it 'should create line item' do      
      expect { post :create_line_item, { id: subject.id, book: {quantity: '1'} } }.to change(LineItem, :count).by(1)
    end
  end

  

end
