class BookPresenter < Rectify::Presenter
  def initialize(book, review = nil)
    @book = book
    @review = review
  end
  attr_reader :book

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
    amount = show_reviews.count
    amount == 0 ? 'There are no reviews yet. Be the first!' : "Reviews(#{amount})"
  end

  def show_reviews    
    book.reviews.where(state: 'approved')
  end

  def show_pictures
    book.pictures
  end
  def previous_path
    cookies['my_previous_url']
  end
    
    def review_form
      @review || ReviewForm.new
    end

  

end