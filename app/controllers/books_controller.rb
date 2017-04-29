class BooksController < ApplicationController
  include Rectify::ControllerHelpers
  load_and_authorize_resource only: [ :show, :update]
  
  def index
  
  end

  def show    
    render_with_presenter

  end

  def update
    PostReview.call(@book, current_user, review_params) do
      on(:ok) do
        redirect_to book_path, notice: "Thanks for Review. It will be published as soon as Admin will approve it."
      end
      on(:invalid) do |form|
        render_with_presenter(form)
        render 'show'
      end
    end
  end

  def create_line_item
    @line_item = @order.add_book(params[:id], line_item_params[:quantity])   
    if @line_item.save
      to_back
    else
      render action: 'new',  alert: "Somthing went wrong"
    end
  end

private

  def render_with_presenter(review = nil)
    @presenter =  BookPresenter.new(@book, review)
    @previous_path = cookies['my_previous_url']
  end

  def book_params
    params.require(:book).permit(:title, :description, :image_url, :price)
  end

  def review_params
    params.require(:review).permit(:title, :description, :rate)
  end

  def line_item_params
    params.require(:book).permit(:quantity)
  end

end
