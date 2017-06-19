class CatalogPresenter < Rectify::Presenter
  def initialize(*attrs)
    @books = attrs[0]
    @current_filter = attrs[1]
  end
  attr_reader :books
 
  # def current_filter_title
  #   @current_filter
  # end


  
end