class CatalogController < ApplicationController
  include Rectify::ControllerHelpers
  before_action :get_last_url, only: [:index, :show]
  skip_before_action :clean_last_url 
  def index
    sort_books
  end

  def show
    @category = Category.find(params[:id]) if params[:id]
    sort_books
  end
  

  private

  def get_last_url
    cookies['my_previous_url'] = request.original_url
  end

  def set_sort_type
    session[:sort_type] =
      params[:sort_type] || session[:sort_type] || :title_asc
  end

  def define_current_filter_title(filter)
    @current_filter = Book::SORT_FILTERS[filter.to_sym]
  end

  def sort_books
    set_sort_type
    define_current_filter_title(session[:sort_type])
    @books = SortBooks.call(@category, session[:sort_type])
      .page(params[:page] || 1).per(4)
  end
  
   
end