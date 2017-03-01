class UsersController < ApplicationController
  include Rectify::ControllerHelpers
  before_action :set_form, :set_countries
  def new
    
  end

  def update_address
   
    @form = AddressForm.from_params(params)
     #byebug
    UpdateAddress.call(@form) do
      on(:ok) do 
        redirect_to settings_path(current_user)
      end
      on(:invalid) do

      end      
    end
  end

private
  
  def set_form
    @form = AddressForm.new
  end

  def set_countries
    @countries = Country.select(:id, :name, :code)
  end


end
