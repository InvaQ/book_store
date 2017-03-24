class PaymentPresenter < Rectify::Presenter
  def initialize(order, form = nil)
    @order = order
    @form = form
  end

  def payment_form
    @form ||= priority_info
  end

  private

  def priority_info
    @order.credit_card || CreditCardForm.new
  end

end