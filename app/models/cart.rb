class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy

  def add_book(book_id, quantity)
    current_item = line_items.find_by(book_id: book_id)
    if current_item
      current_item.quantity += quantity
    else
      current_item = line_items.build(book_id: book_id)
      current_item.price = current_item.book.price
    end
    current_item
  end

  def amount_of_books
    self.line_items.sum('quantity')
  end

  def total_cart_price
    self.line_items.inject(0) do |sum, line|
      sum + line.total_price
    end
  end
  
end
