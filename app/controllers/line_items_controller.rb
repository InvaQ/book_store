class LineItemsController < ApplicationController
  
  
  def destroy
    @line_item = LineItem.find(params[:id])
    @line_item.destroy if @line_item
    redirect_to cart_path
  end
 
end
