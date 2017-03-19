class StepConfirm < Rectify::Command

  def initialize(params, object)
    @params = params[:place_order]
    @order = object
  end

  def call
    return broadcast(:invalid) if @params == true
    broadcast(:ok) if place_order
  end

private

  def place_order
    @order.place_order
    @order.created_at = Time.now
    session[:cart_id]=nil
    send_email
    @order.save
  end

  def send_email
    ApplicationMailer.send_email(@order.user, @order)
  end

end