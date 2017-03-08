class BooksController < ApplicationController
  include Rectify::ControllerHelpers
  load_and_authorize_resource only: [ :show, :update]


  def index
  
  end

  def show    
    @previous_path = cookies['my_previous_url']
    @review_form = ReviewForm.new  
  end

  def update
    PostReview.call(@book, current_user, review_params) do
      on(:ok) do |book|
        redirect_to book_path, notice: "review sent"
      end
      on(:invalid) do |form|
        expose form: form
        flash_render :show, alert: 'awdsdefg'

      end
    end

  end


private

  def book_params
    params.require(:book).permit(:title, :description, :image_url, :price)
  end

  def review_params
    params.require(:review).permit(:title, :description, :rate)
  end

end
