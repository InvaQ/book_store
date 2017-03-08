class StepAddress < UpdateAddress

def initialize(params ,object)
  @params = params[:order].permit!
  @object = object
  @billing = @params[:billing]
  @shipping = @params[:shipping]
end

def call
  #set_form
  
    
    #return broadcast(:invalid) if form.invalid? 
    #use_billing if params[:use_billing] == true   
      broadcast(:ok) if change_address
    #.............
  end

  private
  attr_reader :form, :params

  def use_billing
    @params[:shipping].merge!(@params[:billing].except(:addressable_type))
  end

  def change_address
    @params.each do |address|
      if @object.respond_to?("#{address}_address")
        @object.send("#{address}_address") != nil ? update_address(address) : add_address(address)

      end
    end
  end

  def update_address(type)
    @object.send("#{type}_address").update(instance_variable_get("@#{type}"))
  end

  def add_address(type)
    @object.send("create_#{type}_address", instance_variable_get("@#{type}")) 
  end

  def set_form
    @billing_params = params[:order]
    @form ||= AddressForm.from_params(params)
  end


end