class CheckoutsController < ApplicationController
  include Wicked::Wizard
  include Rectify::ControllerHelpers
  before_action :authenticate_user!  
  steps :address, :delivery, :payment, :confirm, :complete
  #before_action :set_forms
  before_action :set_countries, :set_steps
  before_action :check_accessibility, only: :show

  


  def show
    render_with_presenters(@order)
  end

  def update

    "Step#{step.capitalize}".constantize.call(params, @order) do
      on(:ok) { redirect_to next_wizard_path }
      on(:invalid) do |*attrs|  
        render_with_presenters(@order, *attrs)
      end
    end
  end

  private

    def set_countries
      @countries = Country.select(:id, :name)
    end

    def set_forms
      @billing = priority_address('billing_address')
      @shipping = priority_address('shipping_address')        
      @use_billing = session[:use_billing]
    end

    def priority_address(type)
      @order.public_send(type).nil? ? current_user.public_send(type) : @order.public_send(type)
    end

    def set_steps
      @steps = steps
    end  

    def check_accessibility
      StepAccessibility.call(step, @order) do
        on(:wrong_url){ render_with_presenters(step: :complete) }
        on(:ok) {  render_with_presenters(@order) }
        on(:empty_cart) { redirect_to cart_path }
        on(:not_allowed) { redirect_to checkout_path(previous_step) }
        
      end
    end

    def render_with_presenters(*attrs)
    
      case step
        when :address then @address_presenter = StepAddressPresenter.new(current_user, *attrs )
        when :confirm then @confirm_presenter = ConfirmPresenter.new(order: @order).attach_controller(self)
        when :payment then @payment_presenter = PaymentPresenter.new(*attrs)
        when :complete then@complete_presenter = CompletePresenter.new(order: @order).attach_controller(self)
      end

      present OrderSummaryPresenter.new(order: @order)
      end_checkout if complete?
      render_wizard
    end

    def end_checkout      
        session[:order_id]=nil
        @order = Order.create
        session[:order_id] = @order.id     
    end

    def complete?
      @order.complete?
    end

 

end