class StepAccessibility < Rectify::Command

  def initialize(step, object)
    @step = step
    @order = object
  end

  def call
    return broadcast(:wrong_url) if pointless_request?
    return broadcast(:empty_cart) if order_empty?
    allowed_step? ? broadcast(:ok) : broadcast(:not_allowed)
  end


  private


  def allowed_step?
    case @step
      when :address then true
      when :delivery then has_addresses?
      when :payment then has_delivery?
      when :confirm then has_payment?
      when :complete then @order.complete?
    end
  end

  def has_addresses?
    @order.shipping_address && @order.billing_address
  end

  def has_delivery?
    @order.delivery_id
  end

  def has_payment?
    @order.credit_card
  end

  def pointless_request?
    @order.state == 'complete' && @step != :complete 
  end

  def order_empty?
    @order.line_items.empty?
  end

end