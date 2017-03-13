class UpdateAddress < Rectify::Command

  def initialize(params, object)
    @params = params.permit!
     @object = object
  end

  def call
    set_form
    binding.pry
    return broadcast(:invalid) if form.invalid?    
      broadcast(:ok) if change_address
    #.............
  end

  protected
  attr_reader :form

  def change_address    
    if @object.respond_to?(form.addressable_type)
      @object.send(form.addressable_type) != nil ? update_address : add_address
    end
  end

  def update_address
    binding.pry
    @object.send("#{form[:addressable_type]}").update(@params[:addresses])
  end

  def add_address
    @object.send("create_#{form[:addressable_type]}", @params[:addresses])
  end

  def set_form

    @form = AddressesForm.from_params(@params)
    binding.pry
  end

end