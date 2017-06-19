class FastRegistrationsController < DeviseController
  before_action :create_user

  def show
    render '/devise/fast/show'
  end

  def quick_registration
    user = resource_class.fast_registration(sign_up_params)
    if user.persisted?
      sign_in(resource_name, user)
      set_flash_message! :notice, :signed_up
      redirect_to after_sign_in_path_for(user)
    else
      redirect_to action: 'show'
    end
  end


  private

  def create_user
    @new_user = @existent_user = resource_class.new
  end

  def sign_up_params
    devise_parameter_sanitizer.sanitize(:sign_up)
  end

end