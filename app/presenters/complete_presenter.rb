class CompletePresenter < Rectify::Presenter
  attribute :order, Order


  def show_order_number
    'Order ' + order.generate_number
  end

  def show_confirmation_detail
    'An order confirmation has been has been sent to ' + order.user.email
  end

  def show_order_date
    order.created_at.strftime('%B %d, %Y')
  end 

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
    'Phone ' + number_to_phone(order.shipping_address.phone, area_code: true)
  end

  def line_items
    order.line_items
  end
  

end