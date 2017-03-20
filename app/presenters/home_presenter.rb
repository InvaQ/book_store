class HomePresenter < Rectify::Presenter


  def show_bestsellers
    Book.joins('LEFT JOIN line_items ON line_items.book_id = books.id')
    .group('books.id').order('count(line_items.book_id) desc').take(4)
  end

  def show_latest_books
    Book.last(2)
  end

  def slider
    show_latest_books.count.times
  end

end