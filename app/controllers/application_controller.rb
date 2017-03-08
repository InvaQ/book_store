class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include CurrentCart

  rescue_from CanCan::AccessDenied do |exception|
    render :file => "#{Rails.root}/public/403.html", :status => 403, :layout => false
  end
  before_action :set_category  
  before_action :set_cart



  private

  def set_category
    @category = Category.get_first_listed
  end

  
  
end
