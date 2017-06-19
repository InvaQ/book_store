class StepPayment < Rectify::Command

def initialize(params, object)
  @params = params[:order]
  @order = object
  
end


def call
  set_form

  return broadcast(:invalid, @form) if @form.invalid? 
    broadcast(:ok, @order) if add_to_order && change_order_state
end

 private
  attr_reader :params

  def add_to_order
    @order.credit_card ? update_card : add_card
  end

  def update_card
    @order.credit_card.update(@form.attributes)
  end 

  def add_card    
    @order.create_credit_card(@form.attributes)
  end

  def change_order_state
    return true if @order.confirm?
    @order.filling_payment
    @order.save
  end

  def set_form
    @form = CreditCardForm.from_params(card_params)
  end

  def card_params
    params.require(:credit_card).permit(:number, :name, :expiry_month, :expiry_year, :cvv)
  end

end