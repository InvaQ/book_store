class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy
  has_one :coupon, dependent: :nullify
  accepts_nested_attributes_for :line_items, allow_destroy: true

  def add_book(book_id, quantity)
    current_item = line_items.find_by(book_id: book_id)
    if current_item
      current_item.quantity += quantity
    else
      current_item = line_items.build(book_id: book_id, quantity: quantity)
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

  def coupon_cost
    coupon ? total_cart_price * coupon.discount * -0.01 : 0.00
  end
  
end
