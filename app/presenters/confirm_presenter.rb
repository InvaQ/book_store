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


  def show_bill_name
    "#{order.billing_address.first_name} #{order.billing_address.last_name}"
  end

  def show_bill_address
    order.billing_address.address
  end

  def show_bill_city_zip
    "#{order.billing_address.city} #{order.billing_address.zip}"
  end

  def show_bill_country
    Country.find(order.billing_address.country_id).name
  end

  def show_bill_phone
    'Phone ' + number_to_phone(order.billing_address.phone, area_code: true)
  end

  def show_delivery_name
    order.delivery.name
  end

  def show_delivery_transfer
    order.delivery.transfer
  end

end