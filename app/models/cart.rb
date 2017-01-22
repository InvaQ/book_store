class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy

  def add_book(book_id)
    current_item = line_items.find_by(book_id: book_id)
    if current_item
      current_item.quantity += 1
    else
      current_item = line_items.build(book_id: book_id)
      current_item.price = current_item.book.price
    end
    current_item
  end
  
end
