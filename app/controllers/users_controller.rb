class UsersController < ApplicationController
  include Rectify::ControllerHelpers
  before_action :set_form,  only: [:settings]
  before_action :set_countries
  def new
    
  end

  def update_address
    @form = AddressForm.from_params(params.permit!)
    UpdateAddress.call(@form, current_user) do
      on(:ok) do 
        success
      end
      on(:invalid) do
        error
      end      
    end
  end

  def update_email
  binding.pry 
  @user = current_user
    if @user.update(user_params)
       success
    else
      error
    end
  end

  def update_password
      binding.pry 
    @user = current_user
    if @user.update_with_password(user_params)
      bypass_sign_in(@user)
      success
    else
      error
    end
  end

private
  
  def set_form
    Address::TYPES.each do |type|
      address=current_user.send("#{type}_address")
      form = AddressForm.from_model(address).get_old_info(current_user)
      instance_variable_set("@#{type}", form)
    end
  end

  def set_countries
    @countries = Country.select(:id, :name, :code)
  end

  def address_params
    params.require(:address).permit(:addressable_type,:first_name, :last_name, :address, :city, :zip,:country_id, :phone)
  end

  def user_params
    params.require(:user).permit(:email, :current_password, :password, :confirm_password)
  end

  def success
    redirect_to settings_path(current_user), notice: 'info successfuly updated'
  end

  def error
    flash_render 'settings', alert: "info can't be changed" 
  end

end
