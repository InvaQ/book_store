class StepAddress < Rectify::Command

  def initialize(params, object)
    @params = params
    @use_billing = params[:use_billing]
    @order = object
  end

  def call     
    check_shipping_params
    check_billing_params
    @shipping_params = 
      use_billing? ? @billing_params.dup : @shipping_params
    return broadcast(:invalid,  @billing_params, @shipping_params) if forms_invalid?
    broadcast(:ok, @order) if change_address
  end

  private
  attr_reader :params

  def change_address
    ShippingAddress.find_or_create_by({ addressable_type: 'Order', addressable_id: @order.id })
    .update(@shipping_params.attributes)
    BillingAddress.find_or_create_by({ addressable_type: 'Order', addressable_id: @order.id })
    .update(@billing_params.attributes)    
  end

  def address_params
    params.require(:order).permit(billing: [:first_name, :last_name,:address, :city, :zip,:country_id, :phone],
     shipping: [:first_name, :last_name,:address, :city, :zip, :country_id, :phone])
  end

  def check_shipping_params
    @shipping_params = AddressesForm.from_params(address_params[:shipping])
  end

  def check_billing_params
    @billing_params = AddressesForm.from_params(address_params[:billing])
  end

  def use_billing?
    session[:use_billing] = params[:use_billing]
    @use_billing == "on"
  end

  def forms_invalid?
    @shipping_params.invalid? && @billing_params.invalid?
  end

end
