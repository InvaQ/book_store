class OrdersController < ApplicationController
  include Rectify::ControllerHelpers
  before_action :authenticate_user!

  def index
    SortOrders.call(params, current_user) do 
      on(:ok) do |order|
        present OrdersPresenter.new(order)
      end      
    end
  end

  def show
    @order = Order.find(params[:id])
    @confirm_presenter = ConfirmPresenter.new(order: @order).attach_controller(self)
    present OrderSummaryPresenter.new(order: @order)
  end

end
