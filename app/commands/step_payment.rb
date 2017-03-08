class StepPayment < Rectify::Command

def initialize(params, object)
  @params = params[:order].permit!
  @order = object
  
end


def call
  set_form

  return broadcast(:invalid) if @form.invalid? 
    broadcast(:ok) if add_to_order
end

 private

  def add_to_order
      @order.credit_card != nil ? update_card : add_card
  end

  def update_card
    binding.pry
    @order.credit_card.update(@form.to_h)
  end 

  def add_card
    binding.pry
    @order.create_credit_card(@form.to_h)
  end

  def set_form
    binding.pry
    @form = CreditCardForm.from_params(@params)
  end

end