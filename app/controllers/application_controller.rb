class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_path, :alert => exception.message
  end
  
  before_action :set_category
  include CurrentCart
  before_action :set_cart



  private

  def set_category
    @category = Category.get_first_listed
  end

  
  
end
