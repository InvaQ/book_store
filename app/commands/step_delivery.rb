class StepDelivery < Rectify::Command

  def initialize(params, object)
    @params = params[:delivery_id]
    @order = object
  end

  def call
    return broadcast(:invalid) unless valid?  
    broadcast(:ok, @order) if add_delivery
  end

  private

  def add_delivery
    @order.assign_attributes(delivery_id: @params)
    @order.total_price = @order.total_cart_price
    @order.user_id = current_user.id  unless @order.user_id
    @order.save
  end

  def valid?
    Delivery.exists?(@params)
  end
  

end