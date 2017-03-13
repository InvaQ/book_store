class UsersController < ApplicationController
  include Rectify::ControllerHelpers
  before_action :authenticate_user!
  before_action :set_forms,  only: [:settings]
  before_action :set_countries
  def new
    
  end

  def update_address
    UpdateAddress.call(params, current_user) do
      on(:ok) do 
        success
      end
      on(:invalid) do
        error
      end      
    end
  end

  def update_email
  @user = current_user
    if @user.update(user_params)
       success
    else
      error
    end
  end

  def update_password
    @user = current_user
    if @user.update_with_password(user_params)
      bypass_sign_in(@user)
      success
    else
      error
    end
  end

private
  
  def set_forms
    Address::TYPES.each do |type|
      instance_variable_set("@#{type}", current_user.send("#{type}_address"))
    end
end

  def set_countries
    @countries = Country.select(:id, :name)
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
    #flash_render 'settings', 
    #alert: "info can't be changed" 
  end

end
