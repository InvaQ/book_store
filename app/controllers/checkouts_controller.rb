class CheckoutsController < ApplicationController
  include Wicked::Wizard
  include Rectify::ControllerHelpers
  before_action :set_countries, :set_form
  steps :address, :delivery, :payment, :confirm, :complete


  def show
    @order = Order.last
    #binding.pry
    render_wizard
  end


  def update
    binding.pry
    @order = Order.last
    "Step#{step.capitalize}".constantize.call(params, @order) do
      on(:ok) { redirect_to next_wizard_path }
      on(:invalid) {}
    end
  end


  private 
  def set_countries
    @countries = Country.select(:id, :name)
  end

  def set_form
    Address::TYPES.each do |type|
      address=current_user.send("#{type}_address")
      form = AddressForm.from_model(address).get_old_info(current_user)
      instance_variable_set("@#{type}", form)
    end
  end

  def address_params
    params.permit!
  end

  # def render_step
  #   params[:action] == 'show' ? render_wizard : render("checkouts/#{params[:id]}")
  # end



end