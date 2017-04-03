class SortBooks < Rectify::Command
  DEFAULT = :title_asc
  def initialize(category = nil, params)
    @category = category
    @sort = params
  end  

  def call
    collect_books   
  end

  private

  def collect_books
    @category.nil? ? Book.send(check_sort) : @category.books.send(check_sort)
  end

  def check_sort
    Book::SORT_FILTERS.key?(@sort.to_sym) ? @sort : DEFAULT
  end

end