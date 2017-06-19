class SortOrders < Rectify::Command
  FILTERS = ['all', 'complete', 'in_transit', 'delivered', 'canceled'].freeze
  def initialize(params, object)
    @user = object
    @params = params
  end  

  def call    
    @filter = check_filter
    broadcast(:ok, collect_orders(@filter), @filter)
  end

  private

  def collect_orders(filter)
    return @user.orders if filter == 'all'
    @user.orders.where(state: filter)
  end

  def set_filter_params
    @params[:filter]
  end

  def check_filter
    FILTERS.include?(set_filter_params) ? set_filter_params : 'all'
  end
end