class ConfirmPresenter < Rectify::Presenter
  attribute :order, Order

  def show_ship_name
    "#{order.shipping_address.first_name} #{order.shipping_address.last_name}"
  end

  def show_ship_address
    order.shipping_address.address
  end

  def show_ship_city_zip
    "#{order.shipping_address.city} #{order.shipping_address.zip}"
  end

  def show_ship_country
    Country.find(order.shipping_address.country_id).name
  end

  def show_ship_phone
    'Phone ' + order.shipping_address.phone
  end

  def show_credit_card
    '************' + order.credit_card.number.last(4)
  end

  def show_order_number
    'Order ' + order.generate_number
  end

end