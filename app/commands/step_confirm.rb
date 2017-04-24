class StepConfirm < Rectify::Command

  def initialize(params, object)
    @params = params
    @order = object
  end

  def call
    return broadcast(:invalid) unless confirm_params[:place_order] == "true"
    broadcast(:ok, @order) if place_order
  end

private
  attr_reader :params

  def place_order
    @order.created_at = Time.now    
    send_email if @order.user.respond_to?(:email) 
    @order.place_order
    @order.save
  end

  def send_email
    ApplicationMailer.send_email(@order.user, @order)
  end

  def confirm_params
    params.require(:order).permit(:place_order)
  end
end
