class UsersController < ApplicationController
  include Rectify::ControllerHelpers
  before_action :authenticate_user!
  before_action :set_countries
 
  def settings
    present AddressesPresenter.new
  end

  def update_address
    UpdateAddress.call(params, current_user) do
      on(:ok) do 
        success
      end
      on(:invalid) do |*attrs|        
        present AddressesPresenter.new(*attrs)
        render 'settings'
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
  

  def set_countries
    @countries = Country.select(:id, :name)
  end

  def user_params
    params.require(:user).permit(:email, :current_password, :password, :confirm_password)
  end

  def success
    redirect_to settings_path(current_user), notice: 'info successfuly updated'
  end

  def error
    present AddressesPresenter.new      
    render action: 'settings'
  end


end
