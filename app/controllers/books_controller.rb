class BooksController < ApplicationController

  def index
   # @books = Book.all
  end


  def show
    @book = Book.find(params[:id])
  end


private

  def book_params
    params.require(:book).permit(:title, :description, :image_url, :price)
  end

end
