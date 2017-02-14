class Category < ApplicationRecord
  has_many :categorizations
  has_many :books, through: :categorizations

  def books_in_category
    books.count
  end

end



