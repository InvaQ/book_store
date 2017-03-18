class StepConfirm < Rectify::Command

  def initialize(params, object)
    binding.pry
    @params = params[:place_order]
    @order = object
  end

  def call
    binding.pry
    return broadcast(:invalid) if @params == true
    broadcast(:ok) if place_order
  end

private

  def place_order
    @order.place_order
    @order.updated_at = Time.now
    @order.save
  end

  def send_email

  end

end