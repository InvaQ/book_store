class BookPresenter < Rectify::Presenter
  attribute :book, Book

  def show_book_title
    book.title
  end

  def show_author_names
    book.get_author_names
  end

  def show_book_price
    number_to_currency(book.price)
  end

  def show_short_description
    truncate(book.description, length:60)
  end

  def show_book_publication
    book.publication
  end

  def show_book_dimensions
    book.get_book_dimensions
  end

  def show_book_materials
    book.materials
  end

  def show_count_of_reviews
    amount = book.reviews.count
    amount == 0 ? 'There are no comments yet. Be first!' : amount
  end

  def show_reviews
    book.reviews
  end

  def show_pictures
    book.pictures
  end

end