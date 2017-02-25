class LineItemsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:create]
  before_action :set_line_item, only: [:show, :edit, :destory, :update]
  before_action :sanitizer_page_params, only: [:create]


  def new
    @line_item = LineItem.new
  end

  def create
    @line_item = @cart.add_book(params[:book][:book_id], params[:book][:quantity])   
    if @line_item.save
      redirect_to catalog_index_path  
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

  def destory
    @line_item.destroy
    redirect_to line_items_path
  end

  def decrement
    @cart = current_cart
    @line_item = @cart.line_items.find(line_item_params)
    @line_item.decrement(@line_item.id)

    if @line_item.save
      redirect_to catalog_path
    else
      render action: 'edit'
    end
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
