class UpdateAddress < Rectify::Command

  def initialize(params, object)
    @params = params
     @user = object
  end

  def call
    check_params
    return broadcast(:invalid, @type, @form) if form.invalid?    
    broadcast(:ok) if change_address
  end

  protected
  attr_reader :params, :form

  def change_address
    "#{@type.capitalize}Address".constantize
      .find_or_create_by({ addressable_type: 'User', addressable_id: @user.id })
        .update(form.attributes)
  end

  def address_params
    params.require(:user).permit(billing: [:first_name, :last_name,:address, :city, :zip,:country_id, :phone],
     shipping: [:first_name, :last_name,:address, :city, :zip, :country_id, :phone])
  end

  def check_params
    @form = AddressesForm.from_params(address_params.values[0])
    @type = address_params.keys[0]
  end

end