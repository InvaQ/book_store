class CatalogController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :get_last_url, only: [:index, :show]

  def index
    @books = Book.page(params[:page] || 1).per(4)    
      .order("#{sort_column} #{sort_direction}")

    respond_to do |format|
      format.html
      format.js 
    end
  end

  def show    
    @books = Category.find(params[:id]).books
      .order("#{sort_column} #{sort_direction}")
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

  def get_last_url
    cookies['my_previous_url'] = request.original_url
  end
  
   
end
