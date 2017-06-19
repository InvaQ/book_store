class OrderSummaryPresenter < Rectify::Presenter
  attribute :order, Order

  def show_coupon_info
    number_to_currency(order.coupon_cost) 
  end

  def show_delivery_info
    number_to_currency(order.delivry_cost) 
  end

  def show_subtotal_cart_price
    number_to_currency(order.subtotal_cart_price)
  end

  def show_total_cart_price
    number_to_currency(order.total_cart_price)
  end

  def has_coupon?
    order.coupon.present?
  end

  def has_delivery?
    order.delivery.present?
  end

end