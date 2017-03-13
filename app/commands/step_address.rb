class StepAddress < Rectify::Command

def initialize(params ,object)
  @params = params
  @mark = params[:use_billing]
  @object = object 
end

  def call
    return broadcast(:invalid, @shipping_params, @billing_params ) if check_shipping_params.invalid? || check_billing_params.invalid?  
      broadcast(:ok) if change_address
  end

  private
  attr_reader :params

  def change_address
  
    @billing_params = @mark == "on" ? @shipping_params.dup : @billing_params  
    
    ShippingAddress.find_or_create_by({ addressable_type: 'Order', addressable_id: @object.id })
    .update(@shipping_params.to_h.except(:id))
    BillingAddress.find_or_create_by({ addressable_type: 'Order', addressable_id: @object.id })
    .update(@billing_params.to_h.except(:id) )
    
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

end
