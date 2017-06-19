class HomeController < ApplicationController
  include Rectify::ControllerHelpers

  def index
    present HomePresenter.new
  end

  private

  
end
