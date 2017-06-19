class OrdersPresenter < Rectify::Presenter
  def initialize(*attrs)
    @orders = attrs[0]
    @filter = attrs[1]
  end

  def orders
     @orders
  end

  def have_any_orders?
    @orders.present?
  end

  def current_order_filter  
    @filter || 'All'
  end 

  
end