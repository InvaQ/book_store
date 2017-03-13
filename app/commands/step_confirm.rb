class StepConfirm < Rectify::Command

  initialize(params, object)
    @params = params
    @object = object
  end

  def call
    if place_order_params == true
    broadcast(:ok, @object)
  end

private

  def place_order_params
    @params.permit(:place_order)
  end

  def send_email

  end

end