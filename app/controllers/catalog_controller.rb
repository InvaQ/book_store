class CatalogController < ApplicationController
  before_action :set_category
  helper_method :sort_column, :sort_direction

  def index
    #byebug
    if params[:id]
      @books = Book.where('id > ?', params[:id]).limit(4)
    else
      @books = Book.limit(4)
    end.order("#{sort_column} #{sort_direction}")

    respond_to do |format|
      format.html
      format.js 
    end
  end

  def show    
    @books = Category.find(params[:id]).books.order("#{sort_column} #{sort_direction}")
  end


  

  private

  def sortable_columns
    ["title", "price", "created_at"]
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def sort_column
    sortable_columns.include?(params[:column]) ? params[:column] : "title"
  end
  def set_category
    @category = Category.first(3)
  end

   
end
