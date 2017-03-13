class LineItemsController < ApplicationController
  include CurrentOrder
  before_action :set_order, only: [:create, :destroy]
  before_action :set_line_item, only: [:show, :edit, :destroy, :update]
  before_action :sanitizer_page_params, only: [:create]

  

  def new
    @line_item = LineItem.new
  end

  def create
    @line_item = @order.add_book(params[:book][:book_id], params[:book][:quantity])   
    if @line_item.save
      redirect_to :back 
    else
      render action: 'new'
    end
  end

  def show

  end

  def edit

  end

  def update
    if @line_item.update(line_item_params)
      redirect_to @line_item
    else
      render action: 'edit'
    end
  end

  def destroy
    @line_item.destroy
    redirect_to @cart
  end


  private

  def sanitizer_page_params
   params[:book][:book_id]=params[:book][:book_id].to_i
   params[:book][:quantity]=params[:book][:quantity].to_i
  end

  def line_item_params
    params.require(:line_item).permit(:book_id, :amount)
  end

  def set_line_item
    @line_item = LineItem.find(params[:id])
  end
end
