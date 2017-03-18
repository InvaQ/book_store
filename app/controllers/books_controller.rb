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

  def create_line_item
    @line_item = @order.add_book(params[:id], line_item_params[:quantity])   
    if @line_item.save
      redirect_to :back 
    else
      render action: 'new'#render flash
    end
  end

private

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
