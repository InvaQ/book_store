class OrdersPresenter < Rectify::Presenter
  def initialize(orders)
    @orders = orders
  end

  def orders
     @orders
  end

  def have_any_orders?
    @orders.present?
  end

  

  
end