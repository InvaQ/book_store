class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include CurrentOrder
 
  rescue_from CanCan::AccessDenied do |exception|
    render :file => "#{Rails.root}/public/403.html", :status => 403, :layout => false
  end

  before_action :set_i18n_locale_from_params
  before_action :set_category  
  before_action :set_order



  protected

  def set_category
    @category = Category.get_first_listed
  end


  def fast_authenticate_user!#remove!
    return if user_signed_in?
    session['user_return_to'] = request.fullpath
    redirect_to new_user_session_path
  end

  def set_i18n_locale_from_params
      if params[:locale]
        if I18n.available_locales.map(&:to_s).include?(params[:locale])
          I18n.locale = params[:locale]
        else
          flash.now[:notice] = "#{params[:locale]} translation is not available"
          logger.error flash.now[:notice]
        end
      end
    end

  def default_url_options
  { locale: I18n.locale }
  end
  
end
