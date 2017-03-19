class OrderSummaryPresenter < Rectify::Presenter
  attribute :order, Order

  def show_coupon_info
    "Coupon: #{number_to_currency(order.coupon_cost)}" if order.coupon.present?
  end

  def show_delivery_info
    "Delivery: #{number_to_currency(order.delivry_cost)}" if order.delivery.present?
  end

  def show_subtotal_cart_price
    "Subtotal: #{number_to_currency(order.subtotal_cart_price) }"
  end

  def show_total_cart_price
    "Total price: #{number_to_currency(order.total_cart_price)}"
  end

end