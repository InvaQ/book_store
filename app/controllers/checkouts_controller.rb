class CheckoutsController < ApplicationController
  include Wicked::Wizard
  include Rectify::ControllerHelpers
  include CurrentOrder
  before_action :authenticate_user!
  before_action :set_countries, :set_order, :set_steps, :set_forms
  after_action :connect_to_user, only: :show
  steps :address, :delivery, :payment, :confirm, :complete


  def show
    render_wizard
  end


def update
  binding.pry
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
    Address::TYPES.each do |type|
      instance_variable_set("@#{type}", priority_address(type))
    end
end

def priority_address(type)
  if @order.respond_to?("#{type}_address")
    @order.send("#{type}_address")
  else
    current_user.send("#{type}_address")
  end
end

def set_steps
  @steps = steps
end

def connect_to_user
  unless @order.user_id
    @order.user_id = current_user.id
  @order.save
  end  
end
 


end