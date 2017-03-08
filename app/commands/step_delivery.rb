class StepDelivery < Rectify::Command

  def initialize(params, object)
    @params = params[:delivery_id]
    @order = object
  end

  def call
    return broadcast(:invalid) unless valid?  
    broadcast(:ok) if add_delivery
  end

  private

  def add_delivery
    @order.update(delivery_id: @params)
  end

  def valid?
    Delivery.exists?(@params)
  end
  

end