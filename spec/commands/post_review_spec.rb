require 'rails_helper'

describe PostReview do
  let(:user) { create :user }
  let(:book) { create :book }
  let(:params) { { review: attributes_for(:review) } }

  context '#call' do
    subject { PostReview.new(user, book, params) }

    context 'valid' do
      it 'set ok broadcast' do
        expect { subject.call }.to broadcast(:ok)
      end
      it 'create review' do
        expect { subject.call }.to change { Review.count }.by(1)
      end
    end
  end
end