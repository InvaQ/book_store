class CheckoutsController < ApplicationController
  include Wicked::Wizard
  include Rectify::ControllerHelpers
  before_action :authenticate_user!
  before_action :set_countries, :set_steps
  before_action :check_accessibility, only: :show  
  steps :address, :delivery, :payment, :confirm, :complete


  def show
    
  end

  def update
    "Step#{step.capitalize}".constantize.call(params, @order) do
      on(:ok) { redirect_to next_wizard_path }
      on(:invalid) do |*attrs|  
        render_wizard
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
    end

    def priority_address(type)
      if @order.respond_to?(type)
        @order.public_send(type)
      else
        current_user.public_send(type)
      end
    end

    def set_steps
      @steps = steps
    end  

    def check_accessibility
      StepAccessibility.call(step, @order) do
        on(:ok) { render_with_presenters }
        on(:not_allowed) { redirect_to checkout_path(previous_step) }
        on(:wrong_url){ redirect_to :back }
      end
    end

    def render_with_presenters
      case step
        when :address then set_forms
        when :confirm then @confirm_presenter = ConfirmPresenter.new(order: @order).attach_controller(self)
        when :complete then @complete_presenter = CompletePresenter.new(order: @order).attach_controller(self)
      end

      present OrderSummaryPresenter.new(order: @order)
      render_wizard
    end

end