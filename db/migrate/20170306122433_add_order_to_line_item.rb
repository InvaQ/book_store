class AddOrderToLineItem < ActiveRecord::Migration[5.0]
  def change
    add_reference :line_items, :order, index: true
  end
end
