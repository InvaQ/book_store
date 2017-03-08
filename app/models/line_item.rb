class LineItem < ApplicationRecord
  belongs_to :book
  belongs_to :cart
  belongs_to :order

  def total_price
    book.price * quantity
  end

  def decrement_quantity(line_item_id)
    current_item = LineItem.find(line_item_id)
    if current_item > 1
      current_item.quantity =- 1
    else
      current_item.quantity.destroy
    end
    current_item
  end

end
